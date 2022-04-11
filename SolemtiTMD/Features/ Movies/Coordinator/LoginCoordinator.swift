//
//  LoginCoordinator.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 10/04/22.
//


import UIKit

class LoginCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginController()
    }
    
    func showLoginController()  {
        let controller = LoginViewController()
        self.navigationController.pushViewController(controller, animated: true)
    }
}

extension LoginCoordinator: LoginModelCoordinadorDelegate{
    
    func showErrorLogin(withError error: Error) {
        DispatchQueue.main.async {
            let alert = AlertHelper(withTitle: "Ops", withMessage: error.localizedDescription)
            self.navigationController.present(alert.showWarning(), animated: true, completion: nil)
        }
    }
}
