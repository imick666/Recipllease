//
//  CoreDataTest.swift
//  RecipleaseTests
//
//  Created by mickael ruzel on 18/10/2020.
//

import XCTest
@testable import Reciplease

class CoreDataTest: XCTestCase {

    var cdStack: CoreDataManager?
    
    override func setUp() {
        cdStack = CoreDataManager(context: FakeContext.createFakeContext())
    }
    
    override func tearDown() {
        cdStack = nil
    }
    
    func testReadCoreData() {
        let items = cdStack?.allRecipes
        
        XCTAssertEqual(items?.count, 0)
    }
    
    func testSaveRecipeAfterNetworkCall() {
        let network = NetworkServices(session: FakeAlamoSession(response: .good, data: .json, error: nil))
        network.getRecipes(q: ["nil"]) { (result) in
            guard case .success(let data) = result else {
                XCTFail()
                return
            }
            self.cdStack?.storeRecipe(data[0])
        }
        
        XCTAssertEqual(cdStack?.allRecipes.count, 1)
        XCTAssertEqual(cdStack?.allRecipes[0].name, "Côte de Boeuf with Caramelized Shallots")
    }
    
    func testDeleteStoredRecipe() {
        
        //Get recipe from network
        let network = NetworkServices(session: FakeAlamoSession(response: .good, data: .json, error: nil))
        network.getRecipes(q: ["nil"]) { (result) in
            guard case .success(let data) = result else {
                XCTFail()
                return
            }
            
            //Store recipe
            self.cdStack?.storeRecipe(data[0])
        }
        
        //Get recipes from CoreData
        guard let items = cdStack?.allRecipes else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items[0].name, "Côte de Boeuf with Caramelized Shallots")
        
        //Delete Recipe
        cdStack?.deleteRecipe(items[0])
        
        //Update "items" from newCoreData contents
        guard let newItems = cdStack?.allRecipes else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(newItems.count, 0)
        
    }

}
