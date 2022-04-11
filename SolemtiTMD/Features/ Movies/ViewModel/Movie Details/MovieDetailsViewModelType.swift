//
//  MovieDetailsViewModelType.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
protocol MovieDetailsViewModelType {
    var movieAPI: APIMovieProtocol { get }
    var movie: MovieDetails? { get set }
    
    var movieId: Int { get set }
    var headerText: String { get }
    
    func viewDidLoad()
}
