//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by mickael ruzel on 04/10/2020.
//

import XCTest
@testable import Reciplease

class RecipesTests: XCTestCase {
    
    func testNoResponse() {
        let exp = expectation(description: "wait for queue")
        let network = NetworkServices(session: FakeAlamoSession(response: nil,
                                                                data: nil,
                                                                error: nil))
        
        network.getRecipes(q: []) { (result) in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertEqual(error.description, "The server is not availible, please try again later")
        }
        
        wait(for: [exp], timeout: 0.01)
    }
    
    func testBadResponse() {
        let exp = expectation(description: "Wait for queue")
        
        let NetworkService = NetworkServices(session: FakeAlamoSession(response: .bad,
                                                                       data: nil,
                                                                       error: nil))
        NetworkService.getRecipes(q: []) { (result) in
            guard case.failure(let error) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertEqual(error.description, "sorry but the response is not 200")
        }
        
        wait(for: [exp], timeout: 0.01)
    }
    
    func testNoData() {
        let exp = expectation(description: "Wait for queue")
        
        let network = NetworkServices(session: FakeAlamoSession(response: .good,
                                                                data: nil,
                                                                error: nil))
        network.getRecipes(q: []) { (result) in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertEqual(error.description, "there's no data, sorry")
        }
        
        wait(for: [exp], timeout: 0.01)
    }
    
    func testDataUndecodable() {
        let exp = expectation(description: "wait for queue")
        
        let network = NetworkServices(session: FakeAlamoSession(response: .good, data: .corrupt, error: nil))
        network.getRecipes(q: []) { (result) in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertEqual(error.description, "Sorry this is not the good data")
        }
        
        wait(for: [exp], timeout: 0.01)
    }
    
    func testGoodData() {
        let exp = expectation(description: "wait for queue")
        let network = NetworkServices(session: FakeAlamoSession(response: .good, data: .json, error: nil))
        network.getRecipes(q: []) { (result) in
            guard case .success(let data) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertEqual(data.hits[0].recipe.image, "https://www.edamam.com/web-img/fcc/fccc8cd18dc0310068ebde427e0c1d0c.jpg")
        }
        wait(for: [exp], timeout: 0.01)
    }
}
