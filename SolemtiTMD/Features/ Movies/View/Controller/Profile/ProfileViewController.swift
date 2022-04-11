//
//  ProfileViewController.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 11/04/22.
//

import Foundation
import UIKit
import ViewAnimator

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblUsername: UILabel!
    let viewModel = MovieViewModel()
    var actualPath : String = "/movie/popular"
    
    
    let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    var stopAnimation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let username = UserDefaults.standard.string(forKey: "username"){
            lblUsername.text = "@"+username
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        viewModel.getFavorites()
        viewModel.viewModelDelegate = self
        
    }
    
   
    
    func reloadData()  {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}



// MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.setup(withMovie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.numberOfItems() - 1 {
            print("last cell \(indexPath.row) ")
          
            guard let page = self.viewModel.pagination?.page else { return }
            self.viewModel.pagination?.page = page + 1
            self.viewModel.getFavorites()
        }else{
            
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
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

extension ProfileViewController: MovieViewModelDelegate{
    func updateScreen() {
        self.reloadData()
    }
    
    func startRequest() {
        
    }
    
    func endRequest() {
        
    }
}

