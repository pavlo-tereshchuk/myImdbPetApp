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
    private static let key = "k_k6n2nmvu"
    
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
            print("DATA:\(data)")
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
        makeGetRequest(url: "https://imdb-api.com/API/MostPopularMovies/\(BaseNetworkRequest.key)", objectType: MoviesList.self, holder: handler)
    }
    
    func fetchMovieSearch(searchLine:String, handler: @escaping ((Result<Search>)) -> Void){
        let query = searchLine.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        makeGetRequest(url: "https://imdb-api.com/API/SearchMovie/\(BaseNetworkRequest.key)/\(query)", objectType: Search.self, holder: handler)
    }
    
    func fetchMovieOnID(ID:String, handler: @escaping ((Result<MovieAdvanced>)) -> Void){
        makeGetRequest(url: "https://imdb-api.com/en/API/Title/\(BaseNetworkRequest.key)/\(ID)", objectType: MovieAdvanced.self, holder: handler)
    }
    
    
    
//    MARK: - Hardcoded extraction of first poster from the list in order not to create decodable classes
    func fetchPosterForMovieID (id:String, holder: @escaping (String?) -> Void){
        guard let reqURL = URL(string: "https://imdb-api.com/API/Posters/\(BaseNetworkRequest.key)/\(id)") else {
            print("return")
            return
        }
        let session = URLSession.shared
        
        let request = URLRequest(url: reqURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let data = data else {
                print("Data not found")
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                let posters = json["posters"] as! [Any]
                guard posters.count > 0  else {return}
                let poster = posters[0] as! [String:Any]
                let link = poster["link"] as? String
                holder(link)
            }
            catch{
                print("Faced error while processing obtained data")
            }
        })
        
        task.resume()
    }
}


enum Result<T>{
    case success(T)
    case error(RequestException)
}
