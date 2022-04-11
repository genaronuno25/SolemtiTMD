//
//  ViewController.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var baseShadow: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let service = AuthorizationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        endEditingWhenTapped()
    }


    @IBAction func signInAction(_ sender: UIButton) {
        print("entra")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard
            let login = usernameTextField.text,
            let password = passwordTextField.text
        else {
            UIAlertController.showErrorAlert(on: self, message: "Datos incompletos")
            return
        }
        service.login(login: login, password: password) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success( _):
                UserDefaults.standard.set(true, forKey: "loginViewWasShown")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                let viewModel = MovieViewModel()
                let controller = MoviesViewController(viewModel: viewModel)
                viewModel.coodinatorDelegate = self
                if let nav = self.navigationController{
                    nav.setViewControllers([controller], animated: true)
                }
               
            case .failure(let error):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                UIAlertController.showErrorAlert(on: self, message: error.localizedDescription)
            }
        }
    }
    
    
    private func configureUI() {
        activityIndicator.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        baseShadow.layer.cornerRadius = 15
        baseShadow.applyShadow(radius: 10, opacity: 0.06, offsetW: 5, offsetH: 5)
    }

    private func endEditingWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard var keyboardFrame = (userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
        scrollView.setContentOffset(CGPoint(x: 0,
                                            y: scrollView.contentSize.height -
                                                scrollView.bounds.size.height +
                                                scrollView.contentInset.bottom),
                                    animated: true)
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
}

extension LoginViewController: MovieViewModelCoordinadorDelegate{
    
    func showErrorUpcomingMovie(withError error: Error) {
        DispatchQueue.main.async {
            let alert = AlertHelper(withTitle: "Ops", withMessage: error.localizedDescription)
            if let nav = self.navigationController{
                nav.present(alert.showWarning(), animated: true, completion: nil)
            }
           
        }
    }
    
    func didSelectedMovie(movie: Movie, from viewController: UIViewController) {
        print("Selected movie \(movie.originalTitle ?? "Not found name")")
       
        let viewModel = MovieDetailsViewModel(id: movie.id)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        viewModel.coodinatorDelegate = self
        if let nav = self.navigationController{
            nav.pushViewController(controller, animated: true)
        }
    }
}



extension LoginViewController: MovieDetailsCoordinatorDelegate{
    func showMoreAboutMovie(withUrl url: String?, from viewController: UIViewController) {
        guard let homepage = url, let url = URL(string: homepage) else {
            let alert = AlertHelper(withTitle: "Ops", withMessage: "Unable to retrieve url for selected movie")
            if let nav = self.navigationController{
                nav.present(alert.showWarning(), animated: true, completion: nil)
            }
            return
        }
        UIApplication.shared.open(url)
    }
    
    func showErrorMovieDetails(withError error: Error) {
        DispatchQueue.main.async {
            let alert = AlertHelper(withTitle: "Ops", withMessage: error.localizedDescription)
            if let nav = self.navigationController{
                nav.present(alert.showWarning(), animated: true, completion: nil)
            }
        }
    }
    
    
}

