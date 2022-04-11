//
//  UpcomingMoviesCoordinator.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit

class MoviesCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMoviesViewController()
    }
    
    func showMoviesViewController()  {
        let viewModel = MovieViewModel()
        let controller = MoviesViewController(viewModel: viewModel)
        viewModel.coodinatorDelegate = self
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func showMovieDetailsViewController(withMovie movie: Movie) {
        let viewModel = MovieDetailsViewModel(id: movie.id)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        viewModel.coodinatorDelegate = self
        self.navigationController.pushViewController(controller, animated: true)
    }
}

extension MoviesCoordinator: MovieViewModelCoordinadorDelegate{
    
    func showErrorUpcomingMovie(withError error: Error) {
        DispatchQueue.main.async {
            let alert = AlertHelper(withTitle: "Ops", withMessage: error.localizedDescription)
            self.navigationController.present(alert.showWarning(), animated: true, completion: nil)
        }
    }
    
    func didSelectedMovie(movie: Movie, from viewController: UIViewController) {
        print("Selected movie \(movie.originalTitle ?? "Not found name")")
        showMovieDetailsViewController(withMovie: movie)
    }
}

extension MoviesCoordinator: MovieDetailsCoordinatorDelegate{
    func showMoreAboutMovie(withUrl url: String?, from viewController: UIViewController) {
        guard let homepage = url, let url = URL(string: homepage) else {
            let alert = AlertHelper(withTitle: "Ops", withMessage: "Unable to retrieve url for selected movie")
            self.navigationController.present(alert.showWarning(), animated: true, completion: nil)
            return
        }
        UIApplication.shared.open(url)
    }
    
    func showErrorMovieDetails(withError error: Error) {
        DispatchQueue.main.async {
            let alert = AlertHelper(withTitle: "Ops", withMessage: error.localizedDescription)
            self.navigationController.present(alert.showWarning(), animated: true, completion: nil)
        }
    }
    
    
}
