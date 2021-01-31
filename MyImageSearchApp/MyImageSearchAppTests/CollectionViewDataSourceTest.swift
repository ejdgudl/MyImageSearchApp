//
//  CollectionViewDataSourceTest.swift
//  MyImageSearchAppTests
//
//  Created by 김동현 on 2021/01/28.
//

import XCTest
@testable import MyImageSearchApp

class CollectionViewDataSourceTest: XCTestCase {

    var cdv: CollectionViewDatasourceValidator!
    
    override func setUpWithError() throws {

        cdv = CollectionViewDatasourceValidator()
        cdv.collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cdv.imageCellID)

    }

    override func tearDownWithError() throws {
        
        cdv = nil
        
    }
    
    func testCollectionViewDelegateValidator_WhenDidTapCollectionViewCell_ShouldNotReturnThrow() {
        
        XCTAssertNoThrow(try cdv.cellForItemValid(cellID: cdv.imageCellID))
        
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

// MARK: - CollectionView Datasource Validator

class CollectionViewDatasourceValidator {
    
    let imageCellID = "imageCell"
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    func cellForItemValid(cellID: String) throws {
        
        guard let _ = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: IndexPath()) as? ImageCell else {
            throw CellForItemError.canNotMakeReusableCell }
        
    }
}
