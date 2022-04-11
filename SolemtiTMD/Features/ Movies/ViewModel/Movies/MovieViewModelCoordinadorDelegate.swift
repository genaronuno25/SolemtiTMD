//
//  UpcomingViewModelCoordinadorDelegate.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit
protocol MovieViewModelCoordinadorDelegate: class {
    func showErrorUpcomingMovie(withError error: Error)
    func didSelectedMovie(movie: Movie, from viewController: UIViewController)
}
