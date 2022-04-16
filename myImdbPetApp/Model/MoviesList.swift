//
//  MoviesList.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 12.04.22.
//

import Foundation

struct MoviesList: Decodable {
    let items: [Movie]
    let errorMessage: String
}
