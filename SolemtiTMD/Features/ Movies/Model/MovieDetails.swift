//
//  MovieDetails.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation

struct MovieDetails: Codable {
    let adult: Bool?
    let backDropPath: String?
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath:String
    let companies: [Companies]?
    let productionCountry: [Country]
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int
    let language: [Language]?
    let status:String?
    let tagline:String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backDropPath = "backdrop_path"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case companies = "production_companies"
        case productionCountry = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case language = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
