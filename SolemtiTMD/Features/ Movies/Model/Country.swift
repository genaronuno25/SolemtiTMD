//
//  Country.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
struct Country: Codable {
    let id: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case id = "iso_3166_1"
        case name = "name"
    }
}
