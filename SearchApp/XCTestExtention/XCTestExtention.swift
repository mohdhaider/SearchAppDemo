//
//  XCTestExtention.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import UIKit
import XCTest

extension XCTestCase {
    
    func waitForTimeout(for duration: TimeInterval, callback back:((XCTestExpectation) -> Void)?) {
        let waitExpectation = expectation(description: "Waiting")
        //waitExpectation.isInverted = true
        back?(waitExpectation)
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
    
    func waitForVisible(_ element:XCUIElement, timeout wait:TimeInterval) {
        
        let viewExists = element.waitForExistence(timeout: wait)
        XCTAssertTrue(viewExists)
    }
}
