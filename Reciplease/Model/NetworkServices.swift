//
//  NetworkServices.swift
//  Reciplease
//
//  Created by mickael ruzel on 05/10/2020.
//

import Foundation
import Alamofire

final class NetworkServices {
    
    private let baseUrl = "https://api.edamam.com/search"
    
    func getRecipes(q: [String], completionHandler: @escaping (Result<RecipesModel, Error>) -> Void) {
        let identification = ["app_id": APIConfig.app_id, "app_key": APIConfig.app_key, "q": "Chicken"]
        let request = AF.request(baseUrl, method: .get, parameters: identification, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil)
        request.responseJSON { (result) in
            switch result.result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let json):
                guard let jsonData = json as? Data else {
                    return
                }
                do {
                    let data = try JSONDecoder().decode(RecipesModel.self, from: jsonData)
                    completionHandler(.success(data))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }
        
        
    }
    
    func getImage() {
        
    }
}
