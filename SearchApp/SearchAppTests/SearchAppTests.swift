//
//  SearchAppTests.swift
//  SearchAppTests
//
//  Created by Haider on 25/09/21.
//

import XCTest
@testable import SearchApp

class SearchAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchResultsFetching() {
        // This is an example of a functional test case.
        
        var fetchCatsExpectations: XCTestExpectation?
        
        let viewModel = SearchViewModel()
        
        viewModel.viewModelCallbacks.bind { result in
            
            if let message = result as? SearchMessages,
               message ==  .newDataAvailable {
                
                fetchCatsExpectations?.fulfill()
            }
        }
        
        let searchText = "Texas Ranger"
        
        XCTContext.runActivity(named: "Fetch search results for \(searchText)") { _ in
            
            waitForTimeout(for: 10,
                           callback: { (expectation) in
                            fetchCatsExpectations = expectation
                
                viewModel.getFreshSearchResults(forSearchText: searchText)
            })
        }
    }

    
}
