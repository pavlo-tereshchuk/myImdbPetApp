//
//  Search.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 19.04.22.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let searchType, expression: String
    let results: [SearchResult]
    let errorMessage: String
}

// MARK: - Result
struct SearchResult: Codable {
    let id, resultType, image, title: String
    let resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }
}
