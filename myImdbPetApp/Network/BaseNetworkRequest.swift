//
//  BaseNetworkRequest.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 12.04.22.
//

import Foundation
import AVFoundation

final class BaseNetworkRequest{
    private static let instance = BaseNetworkRequest()
    
    init(){}
    
    static func getInstance() -> BaseNetworkRequest{
        return instance
    }
    
    private func makeGetRequest <T:Decodable>(url:String, objectType:T.Type, holder: @escaping (Result<T>) -> Void){
        guard let reqURL = URL(string: url) else {
            print("return")
            return
        }
        let session = URLSession.shared
        
        let request = URLRequest(url: reqURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                holder(Result.error(RequestException.networkError(error: error!.localizedDescription)))
                return
            }
            guard let data = data else {
                holder(Result.error(RequestException.dataNotFound(error: error!.localizedDescription)))
                return
            }
            do{
                let decoded = try JSONDecoder().decode(T.self, from:data)
                holder(Result.success(decoded))
            }
            catch{
                holder(Result.error(RequestException.jsonParsingError(error: "Faced error while processing obtained data")))
            }
        })
        
        task.resume()
    }
    
    func fetchMostPopularMovies(handler: @escaping ((Result<MoviesList>)) -> Void){
        makeGetRequest(url: "https://imdb-api.com/API/MostPopularMovies/k_k6n2nmvu", objectType: MoviesList.self, holder: handler)
    }
}


enum Result<T>{
    case success(T)
    case error(RequestException)
}
