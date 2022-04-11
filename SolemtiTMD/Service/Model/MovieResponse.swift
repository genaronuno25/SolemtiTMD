//
//  MovieResponse.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
struct MoviesResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPage: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPage = "total_pages"
        case movies = "results"
    }
}
