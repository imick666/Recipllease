//
//  ImagesTest.swift
//  RecipleaseTests
//
//  Created by mickael ruzel on 07/10/2020.
//

import XCTest
@testable import Reciplease

class ImagesTest: XCTestCase {

    func testNoResponse() {
        let exp = expectation(description: "wait for queue")
        
        let session = FakeAlamoSession(response: nil, data: nil, error: nil)
        let network = NetworkServices(session: session)
        
        network.getImage(url: "") { (result) in
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
        let exp = expectation(description: "wait for queue")
        
        let session = FakeAlamoSession(response: .bad, data: nil, error: nil)
        let network = NetworkServices(session: session)
        
        network.getImage(url: "") { (result) in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertEqual(error.description, "sorry but the response is not 200")
        }
        
        wait(for: [exp], timeout: 0.01)
    }
    
    func testNoData() {
        let exp = expectation(description: "wait for queue")
        
        let session = FakeAlamoSession(response: .good, data: nil, error: nil)
        let network = NetworkServices(session: session)
        
        network.getImage(url: "") { (result) in
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
        
        let session = FakeAlamoSession(response: .good, data: .corrupt, error: nil)
        let network = NetworkServices(session: session)
        
        network.getImage(url: "") { (result) in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertEqual(error.description, "Sorry this is not the good data")
        }
        
        wait(for: [exp], timeout: 0.01)
    }
    
    func testAllGood() {
        let exp = expectation(description: "wait for queue")
        
        let session = FakeAlamoSession(response: .good, data: .image, error: nil)
        let network = NetworkServices(session: session)
        
        network.getImage(url: "") { (result) in
            guard case .success(let data) = result else {
                XCTFail()
                return
            }
            exp.fulfill()
            XCTAssertNotNil(data as? UIImage)
        }
        
        wait(for: [exp], timeout: 0.01)
    }
}
