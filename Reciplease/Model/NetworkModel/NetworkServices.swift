//
//  NetworkServices.swift
//  Reciplease
//
//  Created by mickael ruzel on 05/10/2020.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(url: URLConvertible, parameters: [String: Any]?, callback: @escaping (AFDataResponse<Any>) -> Void)
}

final class NetworkSession: AlamoSession {
    func request(url: URLConvertible, parameters: [String: Any]?, callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url, method: .get, parameters: parameters).responseJSON { (result) in
            callback(result)
        }
    }
}

final class NetworkServices {
    
    // MARK: - Properties
    
    private let baseUrl = "https://api.edamam.com/search"
    private let sessions: AlamoSession
    
    // MARK: - Init
    
    init(session: AlamoSession = NetworkSession()) {
        self.sessions = session
    }
    
    // MARK: - Methodes
    
    func getRecipes(q: [String], completionHandler: @escaping (Result<Recipes, NetworkError>) -> Void) {
        
        var query: String {
            var param = ""
            for item in q {
                param.append(item + ",")
            }
            return param
        }
        
        let identification = ["q": query, "app_id": APIConfig.app_id, "app_key": APIConfig.app_key]
        
        sessions.request(url: baseUrl, parameters: identification) { (result) in
            guard let response = result.response else {
                completionHandler(.failure(NetworkError.noResponse))
                return
            }
            guard response.statusCode == 200 else {
                completionHandler(.failure(NetworkError.badResponse))
                return
            }
            guard let jsonData = result.data else {
                completionHandler(.failure(NetworkError.noData))
                return
            }
            do {
                let data = try JSONDecoder().decode(RecipesModel.self, from: jsonData)
                
                var recipes: [Recipe] {
                    var result = [Recipe]()
                    for recipe in data.hits {
                        result.append(recipe.recipe)
                    }
                    return result
                }
                
                completionHandler(.success(recipes))
            } catch {
                completionHandler(.failure(NetworkError.dataUndecodable))
            }
        }
    }
}
