//
//  QueryMovie.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
struct QueryMovie {
    let language: String
    let page: Int
    let adult: Bool
    let query: String
    
    init(language: String, page: Int, adult: Bool, query: String) {
        self.language = language
        self.page = page
        self.adult = adult
        self.query = query
    }
}
