//
//  MovieBasic.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 21.04.22.
//

import Foundation

// MARK: - Result
struct MovieBasic: Decodable {
    let id, resultType, image, title: String
    let resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }
}
