//
//  FakeResponse.swift
//  RecipleaseTests
//
//  Created by mickael ruzel on 06/10/2020.
//

import Foundation

final class FakeResponse {

    enum response {
        case bad, good
        
        var response: HTTPURLResponse {
            switch self {
            case .good:
                return HTTPURLResponse(url: URL(string: "google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            case .bad:
                return HTTPURLResponse(url: URL(string: "google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            }
        }
    }
    
    enum data {
        case good, bad
        
        var data: Data? {
            switch self {
            case .good:
                var goodData: Data {
                    let bundle = Bundle(for: FakeResponse.self)
                    let url = bundle.url(forResource: "RecipesResult", withExtension: "json")!
                    return try! Data(contentsOf: url)
                }
                return goodData
            case .bad:
                var badData: Data {
                    return "ok".data(using: .utf8)!
                }
                return badData
            }
        }
    }
    
    
}
