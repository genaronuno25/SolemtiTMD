//
//  MovieDetailsViewModel.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit
class MovieDetailsViewModel: MovieDetailsViewModelType {
   
    var movieAPI: APIMovieProtocol{
        return APIMovieDefault()
    }
    
    var movie: MovieDetails?
    
    var movieId: Int
    
    weak var coodinatorDelegate: MovieDetailsCoordinatorDelegate?
    weak var viewModelDelegate: MovieDetailsViewModelDelegate?
    
    init(id: Int) {
        self.movieId = id
    }
    
    var headerText: String {
        return "Movie Details"
    }
    
    
    
    func viewDidLoad() {
        movieDetails()
    }
    
    func movieDetails()  {
        viewModelDelegate?.startRequest()
        movieAPI.movieDetails(forMovie: movieId) { (response) in
            self.viewModelDelegate?.endRequest()
            switch response{
            case .success(let response):
                guard let movieDetails = response else { return }
                self.movie = movieDetails
                self.viewModelDelegate?.updateScreen()
            case .failure(let error):
                guard let error = error else { return }
                print(error.localizedDescription)
                self.coodinatorDelegate?.showErrorMovieDetails(withError: error)
            }
        }
    }
    
    func didTapButtonMoreAbout(from controller: UIViewController) {
        coodinatorDelegate?.showMoreAboutMovie(withUrl: self.movie?.homepage , from: controller)
    }
    
}
