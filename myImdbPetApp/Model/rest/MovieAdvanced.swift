//
//  MovieAdvanced.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 23.04.22.
//

import Foundation

// MARK: - Welcome
struct MovieAdvanced: Decodable {
    let id, fullTitle: String
    let image: String
    let plot: String
    let directors: String
    let writers: String
    let stars: String
    let genres: String
    let imDBRating: String
    let errorMessage: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, fullTitle, year, image, plot
        case directors,writers, stars, genres
        case imDBRating = "imDbRating"
        case errorMessage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.fullTitle = try container.decode(String.self, forKey: .fullTitle)
        self.genres = try container.decode(String.self, forKey: .genres)
        self.imDBRating = try container.decode(String.self, forKey: .imDBRating)
        self.image = try container.decode(String.self, forKey: .image)
        self.directors = try container.decode(String.self, forKey: .directors)
        self.writers = try container.decode(String.self, forKey: .writers)
        self.stars = try container.decode(String.self, forKey: .stars)
        self.plot = try container.decode(String.self, forKey: .plot)
        self.errorMessage = try container.decode(JSONNull.self, forKey: .errorMessage)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Decodable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
