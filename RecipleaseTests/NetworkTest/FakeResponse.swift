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

    enum dataType {
        case json, corrupt
        
        var data: Data {
            switch self {
            case .json:
                let bundle = Bundle(for: RecipesTests.self)
                let url = bundle.url(forResource: "RecipesResult", withExtension: "json")!
                return try! Data(contentsOf: url)
            case.corrupt:
                return "corrupt".data(using: .utf8)!
            }
        }
    }
}
