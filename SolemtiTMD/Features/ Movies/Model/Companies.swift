//
//  Companies.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
struct Companies: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
