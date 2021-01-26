//
//  CodableValideTest.swift
//  MyImageSearchAppTests
//
//  Created by 김동현 on 2021/01/27.
//

import XCTest
@testable import MyImageSearchApp

class CodableValideTest: XCTestCase {
    
    var kst: KakaoServiceCodableValidator!

    override func setUpWithError() throws {
        
        kst = KakaoServiceCodableValidator()
        
    }

    override func tearDownWithError() throws {
        
        kst = nil
        
    }
    
    func testKakaoServiceCodableValidator_WhenValidSuccessGetCodableData_ShouldReturnTrue() {
        
        let isCodableValid = kst.isCodableValid(data: SampleData.documents)
        
        XCTAssertTrue(isCodableValid, "isCodableValid() should have returned TRUE")
        
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

// MARK: - KakaoService Codable Validator

class KakaoServiceCodableValidator {
    
    func isCodableValid(data: Data) -> Bool {
        
        do {
            
            _ = try JSONDecoder().decode(SearchResult.self, from: SampleData.documents)
            return true
            
        } catch {
            
            print("\n\(error)\n")
            return false
            
        }
        
    }
    
}

