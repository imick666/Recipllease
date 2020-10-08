//
//  NetworkError.swift
//  Reciplease
//
//  Created by mickael ruzel on 06/10/2020.
//

import Foundation

enum NetworkError: Error {
    case badResponse, noData, dataUndecodable, noResponse
    
    var description: String {
        switch self {
        case .badResponse:
            return "sorry but the response is not 200"
        case .noData:
            return "there's no data, sorry"
        case .dataUndecodable:
            return "Sorry this is not the good data"
        case .noResponse:
            return "The server is not availible, please try again later"
        }
    }
}
