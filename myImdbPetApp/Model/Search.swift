//
//  Search.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 19.04.22.
//

import Foundation

// MARK: - Search
struct Search: Decodable {
    let searchType, expression: String
    let results: [MovieBasic]
    let errorMessage: String
    
    func produceMovieArray() -> [Movie]{
        var movieArray = [Movie]()
        for result in results{
            movieArray.append(Movie(from: result))
        }
    return movieArray
    }
}

