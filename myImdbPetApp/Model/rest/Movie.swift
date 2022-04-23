//
//  Movie.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 28.03.22.
//

import Foundation

public struct Movie: Decodable {
    let id, title: String
    let year: String
    let image: String
    let crew : String
    
    init(from basicMovie: MovieBasic){
        self.id = basicMovie.id
        self.image = basicMovie.image
        self.title = basicMovie.title
        let year = basicMovie.resultDescription.components(separatedBy: CharacterSet(charactersIn: "()"))
                                                .filter({NSRegularExpression("^[0-9]{4}$")
                                                    .matches($0)})
        self.year = year.count > 0 ? year[0]:""
        self.crew = ""
    }


    enum CodingKeys: String, CodingKey {
        case id, title, year, image, crew
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = try container.decode(String.self, forKey: .year)
        self.crew = try container.decode(String.self, forKey: .crew)
    }
}

