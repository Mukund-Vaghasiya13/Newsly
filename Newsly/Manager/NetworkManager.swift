//
//  NetworkManager.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 15/02/25.
//

import UIKit

enum ApiError: String, Error{
    case invalidUrl = "Url invalid"
    case decodingFailed = "Server Error, Network Connection Error"
    case networkCallFailed = "Server Not Responding"
}

class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init(){}
    
    private let baseUrl = "https://newsapi.org/v2/"
    
    var chache = NSCache<NSString, UIImage>()
    
    func getNews(url:String,completion: @escaping (Result<NewslyResponse, ApiError>) -> Void){
        
        let endpoint = baseUrl + url
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
      let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.decodingFailed))
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.networkCallFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.decodingFailed))
                return
            }
            
            
            do{
                let response = try JSONDecoder().decode(NewslyResponse.self, from: data)
                completion(.success(response))
                return
            }catch{
                completion(.failure(.decodingFailed))
                return
            }
        }
        
        task.resume()
        
        
    }

}
