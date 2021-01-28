//
//  CollectionViewDelegateTest.swift
//  MyImageSearchAppTests
//
//  Created by 김동현 on 2021/01/28.
//

import XCTest
@testable import MyImageSearchApp

class CollectionViewDelegateTest: XCTestCase {

    var cdv: CollectionViewDelegateValidator!
    
    var sampleDocuments1: [Document]?
    
    override func setUpWithError() throws {
        
        cdv = CollectionViewDelegateValidator()
        
    }

    override func tearDownWithError() throws {
        
        cdv = nil
        
    }
    
    func testCollectionViewDelegateValidator_WhenDidTapCollectionViewCell_ShouldNotReturnThrow() {

        XCTAssertNoThrow(try cdv.didSelectValid(documents: cdv.sampleDocuments2, row: 2))
        
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

// MARK: - CollectionView Delegate Validator

class CollectionViewDelegateValidator {
    
    var sampleDocuments1: [Document]?
    
    let sampleDocuments2: [Document]? = [
        Document(collection: "", datetime: "", displaySiteName: "", docURL: "", height: 0, imageURL: "", thumbnailURL: "", width: 0),
        Document(collection: "", datetime: "", displaySiteName: "", docURL: "", height: 0, imageURL: "", thumbnailURL: "", width: 0),
        Document(collection: "", datetime: "", displaySiteName: "", docURL: "", height: 0, imageURL: "", thumbnailURL: "", width: 0),
    ]
    
    func didSelectValid(documents: [Document]?, row: Int) throws {
        
        guard let documents = documents else { throw  DetailVCPresentError.noDocuments}
        guard documents.count - 1 >= row else { throw DetailVCPresentError.outOfRange }
        
    }
    
}
