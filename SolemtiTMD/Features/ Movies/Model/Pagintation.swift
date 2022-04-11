//
//  Pagintation.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
struct Pagination{
    var page: Int
    var totalResults: Int
    var totalPage: Int
    
    init(page: Int, totalResults:Int, totalPage: Int) {
        self.page = page
        self.totalResults = totalResults
        self.totalPage = totalPage
    }
}
