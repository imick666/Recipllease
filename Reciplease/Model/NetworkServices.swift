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
    
    private let baseUrl = "https://api.edamam.com/search"
    let sessions: AlamoSession
    
    init(session: AlamoSession = NetworkSession()) {
        self.sessions = session
    }
    
    func getRecipes(q: [String], completionHandler: @escaping (Result<RecipesModel, Error>) -> Void) {
        
        var query: String {
            var param = ""
            for item in q {
                param.append(item + ",")
            }
            return param
        }
        
        let identification = ["q": query, "app_id": APIConfig.app_id, "app_key": APIConfig.app_key]
        
        sessions.request(url: baseUrl, parameters: identification) { (result) in
            guard result.response?.statusCode == 200 else {
                completionHandler(.failure(NetworkError.badResponse))
                return
            }
            guard let jsonData = result.data else {
                completionHandler(.failure(NetworkError.noData))
                return
            }
            do {
                let data = try JSONDecoder().decode(RecipesModel.self, from: jsonData)
                completionHandler(.success(data))
            } catch {
                completionHandler(.failure(NetworkError.dataUndecodable))
            }
        }
    }
    
    func getImage() {
        
    }
}