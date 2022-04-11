//
//  AppCoordinator.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    let rootViewController: UINavigationController
    let upcomingMoviesCoordinator: MoviesCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.window.rootViewController = self.rootViewController
        self.upcomingMoviesCoordinator = MoviesCoordinator(navigationController: rootViewController)
    }
    
    func start() {
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        self.upcomingMoviesCoordinator.start()
    }
}
