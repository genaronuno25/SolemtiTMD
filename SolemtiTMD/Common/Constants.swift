//
//  Constants.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
import UIKit

enum TypeImage {
    case compressedImage
    case fullImage
}

struct Constants {

    static let scheme = "https"
    static let movieHost = "api.themoviedb.org"
    static let movieVersionAPI = "/3"
    static var movieApiKey = "0fdd3f235ae53655472e9d0205276b8c"
    static let language = "en-US"
    static let baseUrl = "https://api.themoviedb.org/3/"
    
    static func movieImageHost(type: TypeImage) -> String{
        var path = ""
        switch type{
        case .compressedImage:
            path = "w500/"
        case .fullImage:
            path = "original/"
        }
        return "https://image.tmdb.org/t/p/"+path
    }
    
}

struct Colors {
    static let appBarTintColor = #colorLiteral(red: 0.02143233083, green: 0.1954729259, blue: 0.185156256, alpha: 1)
    static let appBarTextTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}
