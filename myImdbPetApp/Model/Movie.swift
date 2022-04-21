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
    
    init(from basicMovie: MovieBasic){
        self.id = basicMovie.id
        self.image = basicMovie.image
        self.title = basicMovie.title
        self.fullTitle = basicMovie.title
        let year = basicMovie.resultDescription.components(separatedBy: CharacterSet(charactersIn: "()"))
                                                .filter({NSRegularExpression("^[0-9]{4}$")
                                                    .matches($0)})
        self.year = year.count > 0 ? year[0]:""
        self.rank = ""
        self.rankUpDown = ""
        self.crew = ""
        self.imDBRating = ""
        self.imDBRatingCount = ""
    }


    enum CodingKeys: String, CodingKey {
        case id, rank, rankUpDown, title, fullTitle, year, image, crew
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
    }
}

