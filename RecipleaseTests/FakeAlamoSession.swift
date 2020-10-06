//
//  FakeUrlSession.swift
//  RecipleaseTests
//
//  Created by mickael ruzel on 06/10/2020.
//

import Foundation
import Alamofire
@testable import Reciplease

final class FakeAlamoSession: AlamoSession {
    
    private var response: FakeResponse.response?
    private var data: FakeResponse.data?
    private var error: AFError?
    
    init(response: FakeResponse.response?,
         data: FakeResponse.data?,
         error: AFError?) {
        self.response = response
        self.data = data
        self.error = error
    }
    
    func request(url: URLConvertible, parameters: [String : Any]?, callback: @escaping (AFDataResponse<Any>) -> Void) {
        
        let result = AFDataResponse<Any>(request: nil, response: response?.response, data: data?.data, metrics: nil, serializationDuration: 0, result: .success("ok".data(using: .utf8)!))
        callback(result)
    }
}
