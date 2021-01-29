//
//  CheckRequestAbleTest.swift
//  MyImageSearchAppTests
//
//  Created by 김동현 on 2021/01/30.
//

import XCTest
@testable import MyImageSearchApp

class CheckRequestAbleTest: XCTestCase {
    
    var crav: CheckRequestAbleValidator!

    override func setUpWithError() throws {
        
        crav = CheckRequestAbleValidator()
        
    }

    override func tearDownWithError() throws {
        
        crav = nil
        
    }

    func testCheckRequestAbleTestValidator_WhenTextFeildEdited_ShouldCheckRequestAble() {
        
        XCTAssertNoThrow(try crav.CheckRequestAble(query: "1", history: ""))
        
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// MARK: - Check Request Able Validator

class CheckRequestAbleValidator {
    
    func CheckRequestAble(query: String, history: String) throws {
        
        guard query != "" else {
            throw CheckRequestAbleError.noText
        }
        
        guard query != history else {
            throw CheckRequestAbleError.dontNeedToRequest
        }
        
    }
}
