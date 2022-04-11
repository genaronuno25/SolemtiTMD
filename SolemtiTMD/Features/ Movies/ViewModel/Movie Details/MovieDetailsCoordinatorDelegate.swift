//
//  MovieDetailsCoordinatorDelegate.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit
protocol MovieDetailsCoordinatorDelegate: class {
    func showErrorMovieDetails(withError error: Error)
    func showMoreAboutMovie(withUrl url: String?, from viewController: UIViewController)
}
