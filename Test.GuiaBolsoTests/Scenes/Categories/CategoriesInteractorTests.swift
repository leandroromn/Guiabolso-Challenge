//
//  CategoriesInteractorTests.swift
//  Test.GuiaBolsoTests
//
//  Created by Leandro Romano on 29/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import XCTest
import Cuckoo
import Nimble
import PromiseKit

@testable import Test_GuiaBolso

class CategoriesInteractorTests: XCTestCase {

    var sut: CategoriesInteractor!
    var mockWorker: MockCategoriesWorker!
    
    override func setUp() {
        super.setUp()
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil
        
        mockWorker = MockCategoriesWorker()
        sut = CategoriesInteractor(worker: mockWorker)
    }
    
    func testSetupLoadingState() {
        let mockPresenter = MockCategoriesPresenter()
        
        stub(mockPresenter) { when($0.presentLoadingState()).thenDoNothing() }
        
        sut.presenter = mockPresenter
        sut.setupLoadingState()
        
        verify(mockPresenter, times(1)).presentLoadingState()
    }
    
    func testRequestCategoriesSuccess() {
        let mockPresenter = MockCategoriesPresenter()
        
        stub(mockPresenter) { when($0.presentDynamicData()).thenDoNothing() }
        stub(mockWorker) { when($0.getCategories()).then { .value(["Dev", "Food", "Money"]) } }
        
        sut.presenter = mockPresenter
        sut.requestCategories()
        
        verify(mockPresenter, times(1)).presentDynamicData()
    }
    
    func testRequestCategoriesFailure() {
        let mockPresenter = MockCategoriesPresenter()
        
        stub(mockPresenter) { when($0.presentError(any())).thenDoNothing() }
        stub(mockWorker) { when($0.getCategories()).then { Promise { $0.reject(NetworkError.mappingError) } } }
        
        sut.presenter = mockPresenter
        sut.requestCategories()
        
        verify(mockPresenter, times(1)).presentError(any())
    }
    
    func testCellForRow() {
        sut.categories = ["Dev", "Food", "Money"]
        let viewModel = sut.cellForRow(at: 1)
        
        XCTAssertNotNil(sut.categories)
        XCTAssertEqual(sut.categories.count, 3)
        XCTAssertEqual(viewModel, "Food")
    }
    
    func testDidSelect() {
        let mockPresenter = MockCategoriesPresenter()
        
        stub(mockPresenter) { when($0.presentRandomJoke()).thenDoNothing() }
        
        sut.categories = ["Dev", "Food", "Money"]
        sut.presenter = mockPresenter
        sut.didSelect(at: 1)
        
        XCTAssertNotNil(sut.category)
        XCTAssertEqual(sut.category, "Food")
        XCTAssertEqual(sut.categories.count, 3)
        
        verify(mockPresenter, times(1)).presentRandomJoke()
    }

    override func tearDown() {
        super.tearDown()
        mockWorker = nil
        sut = nil
    }

}
