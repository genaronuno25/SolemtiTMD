//
//  UpcomingMovieViewModel.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit
class MovieViewModel: MovieViewModelType {
    //Mark: - Delegates
    
    weak var coodinatorDelegate: MovieViewModelCoordinadorDelegate?
    weak var viewModelDelegate: MovieViewModelDelegate?
    
    //Mark: - Properties
    
    static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    var movieAPI: APIMovieProtocol{
        return APIMovieDefault()
    }
    
    var movies: [Movie] = []
    
    var headerText: String{
        return "Movies"
    }
    
    var pagination: Pagination?
    
    init() {
        self.pagination = Pagination(page: 1, totalResults: 0, totalPage: 0)
    }
    

    func reloadModel(){
        self.pagination = Pagination(page: 1, totalResults: 0, totalPage: 0)
        self.movies = []
    }
    
    func getMovies(path : String){
        viewModelDelegate?.startRequest()
        guard let pagination = self.pagination else { return }
        movieAPI.getMovies(forPage: String(pagination.page), forLanguage: Constants.language, path: path) { (response) in
            self.viewModelDelegate?.endRequest()
            switch response{
            case .success(let response):
                guard let response = response else { return }
                if response.movies.count > 0 {
                    self.pagination = Pagination(page: response.page, totalResults: response.totalResults, totalPage: response.totalPage)
                    if self.pagination?.page ?? 1 > 1{
                        print(response.movies)
                        self.movies += response.movies as [Movie]
                    }else{
                        self.movies = response.movies
                    }
                    self.viewModelDelegate?.updateScreen()
                }
            case .failure(let error):
                guard let error = error else { return }
                print(error.localizedDescription)
                self.coodinatorDelegate?.showErrorUpcomingMovie(withError: error)
            }
        }
    }
    
    func getFavorites(){
        viewModelDelegate?.startRequest()
        guard let pagination = self.pagination else { return }
        movieAPI.getFavorites(forPage: String(pagination.page), forLanguage: Constants.language) { (response) in
            self.viewModelDelegate?.endRequest()
            switch response{
            case .success(let response):
                guard let response = response else { return }
                if response.movies.count > 0 {
                    self.pagination = Pagination(page: response.page, totalResults: response.totalResults, totalPage: response.totalPage)
                    if self.pagination?.page ?? 1 > 1{
                        print(response.movies)
                        self.movies += response.movies as [Movie]
                    }else{
                        self.movies = response.movies
                    }
                    self.viewModelDelegate?.updateScreen()
                }
            case .failure(let error):
                guard let error = error else { return }
                print(error.localizedDescription)
                self.coodinatorDelegate?.showErrorUpcomingMovie(withError: error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func didSelectRow(_ row: Int, from controller: UIViewController) {
        let movieSelect = self.movies[row]
        coodinatorDelegate?.didSelectedMovie(movie: movieSelect, from: controller)
    }
    
    
    
 
    
    
    
    
    
}
