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
    
    // MARK: - Properties
    
    private var fakeResponse: FakeResponse.response?
    private var fakeData: FakeResponse.dataType?
    private var fakeError: AFError?
    
    // MARK: - Init
    
    init(response: FakeResponse.response?,
         data: FakeResponse.dataType?,
         error: AFError?) {
        self.fakeResponse = response
        self.fakeData = data
        self.fakeError = error
    }
    
    // MARK: - Methodes
    
    func request(url: URLConvertible, parameters: [String : Any]?, callback: @escaping (AFDataResponse<Any>) -> Void) {
        
        let request = AFDataResponse<Any>(request: nil, response: fakeResponse?.response, data: fakeData?.data, metrics: nil, serializationDuration: 0, result: .success("ok"))
        
        callback(request)
    }
}
