//
//  UpcomingViewModelType.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit
protocol MovieViewModelType {
    
    var movieAPI: APIMovieProtocol { get }
    var movies: [Movie] { get set }
    
    var pagination: Pagination? { get set}
    var headerText: String { get }
    
    func didSelectRow(_ row: Int, from controller: UIViewController)
    func numberOfItems() -> Int
}
