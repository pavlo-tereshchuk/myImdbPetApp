//
//  Movie.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 28.03.22.
//

import Foundation

public struct Movie: Decodable {
    let id, rank, rankUpDown, title: String
    let fullTitle, year: String
    let image: String
    let crew, imDBRating, imDBRatingCount: String

    enum CodingKeys: String, CodingKey {
        case id, rank, rankUpDown, title, fullTitle, year, image, crew
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
    }
}

