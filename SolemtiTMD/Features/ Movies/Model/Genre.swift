//
//  Genre.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
struct Genre: Codable {
    let id: Int
    let name: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
