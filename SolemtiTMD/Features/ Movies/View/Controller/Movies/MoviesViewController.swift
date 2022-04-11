//
//  MoviesViewController.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit
import ViewAnimator

class MoviesViewController: BaseViewController<MovieViewModel> {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var svBottomLoading: UIStackView!
    @IBOutlet weak var aiBottomLoading: UIActivityIndicatorView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var constraintBottomSvLoading: NSLayoutConstraint!
    
    let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    var stopAnimation: Bool = false
    var actualPath : String = "/movie/popular"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "loginViewWasShown") == nil{
            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            if let nav = self.navigationController{
                nav.setViewControllers([controller], animated: true)
            }
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        viewModel.getMovies(path: self.actualPath)
        viewModel.viewModelDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let imageSearch = UIImage(named: "menu")
        let searchBarButtonItem = UIBarButtonItem(image: imageSearch, style: .done, target: self, action: #selector(self.createAlertMenu))
       
        self.navigationController?.navigationBar.topItem?.title = "TV Shows"
        self.navigationController?.navigationBar.topItem?.setRightBarButton(searchBarButtonItem, animated: true)
    }
    
    
    @objc func createAlertMenu()  {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

               // Create your actions - take a look at different style attributes
               let reportAction = UIAlertAction(title: "View profile", style: .default) { (action) in
                   // observe it in the buttons block, what button has been pressed
                   let controller:UIViewController = UIStoryboard(name: "ProfileViewController", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as UIViewController
                   if let nav = self.navigationController{
                       nav.pushViewController(controller, animated: true)
                   }
               }

               let blockAction = UIAlertAction(title: "Log out", style: .destructive) { (action) in
                   print("didPress block")
                   UserDefaults.standard.removeObject(forKey: "loginViewWasShown")
                   let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
                   if let nav = self.navigationController{
                       nav.setViewControllers([controller], animated: true)
                   }
                   
               }

               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                   print("didPress cancel")
               }

               // Add the actions to your actionSheet
               actionSheet.addAction(reportAction)
               actionSheet.addAction(blockAction)
               actionSheet.addAction(cancelAction)
               // Present the controller
               self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
        
        switch sender.selectedSegmentIndex{
        case 0:
            self.actualPath = "/movie/popular"
        case 1:
            self.actualPath = "/movie/top_rated"
        case 2:
            self.actualPath = "/tv/on_the_air"
        case 3:
            self.actualPath = "/tv/airing_today"
        default:
            break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewModel.reloadModel()
            self.viewModel.getMovies(path: self.actualPath)
        }
        
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking{
            stopAnimation = true
        }
    }
    
    func reloadData()  {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.animationCollectionView()
        }
    }
    
    func animationCollectionView()  {
        if !stopAnimation{
            let diractionAnimation = AnimationType.from(direction: .bottom, offset: 30.0)
            UIView.animate(views: collectionView.visibleCells,
                               animations: [diractionAnimation],
                               duration: 0.5)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MoviesViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row, from: self)
    }
}

// MARK: - UICollectionViewDataSource

extension MoviesViewController: UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.setup(withMovie: movie)
        animationCollectionView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.numberOfItems() - 1 {
            print("last cell \(indexPath.row) ")
            self.svBottomLoading.isHidden = false
            self.aiBottomLoading.startAnimating()
            self.constraintBottomSvLoading.constant = 22
            guard let page = self.viewModel.pagination?.page else { return }
            self.viewModel.pagination?.page = page + 1
            self.viewModel.getMovies(path: actualPath)
        }else{
            self.svBottomLoading.isHidden = true
            self.aiBottomLoading.stopAnimating()
            self.constraintBottomSvLoading.constant = -90
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 16
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        if screenSize.width >= 414 && screenSize.height >= 896{
            return CGSize(width: 180, height: 250)
        }else{
             return CGSize(width: 160, height: 230)
        }
    }
}

extension MoviesViewController: MovieViewModelDelegate{
    func updateScreen() {
        self.reloadData()
    }
    
    func startRequest() {
        DispatchQueue.main.async {
            self.aiLoading.startAnimating()
        }
    }
    
    func endRequest() {
        DispatchQueue.main.async {
            self.aiLoading.stopAnimating()
            self.aiLoading.isHidden = true
        }
    }
}
