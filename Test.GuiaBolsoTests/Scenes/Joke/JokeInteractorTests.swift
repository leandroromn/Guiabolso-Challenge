//
//  JokeInteractorTests.swift
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

class JokeInteractorTests: XCTestCase {

    var sut: JokeInteractor!
    var mockWorker: MockJokeWorker!
    
    override func setUp() {
        super.setUp()
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil
        
        mockWorker = MockJokeWorker()
        sut = JokeInteractor(worker: mockWorker)
        sut.category = "Dev"
        sut.jokeUrl = "a-valid-url"
    }
    
    func testSetupViewTitle() {
        let mockPresenter = MockJokePresenter()
        
        stub(mockPresenter) { when($0.presentView(title: any())).thenDoNothing() }
        
        sut.presenter = mockPresenter
        sut.setupViewTitle()
        
        verify(mockPresenter, times(1)).presentView(title: any())
    }
    
    func testSetupLoadingState() {
        let mockPresenter = MockJokePresenter()
        
        stub(mockPresenter) { when($0.presentLoadingState()).thenDoNothing() }
        
        sut.presenter = mockPresenter
        sut.setupLoadingState()
        
        verify(mockPresenter, times(1)).presentLoadingState()
    }
    
    func testRequestRandomJokeSuccess() {
        let mockPresenter = MockJokePresenter()
        
        stub(mockPresenter) { stub in
            when(stub.presentFilledState()).thenDoNothing()
            when(stub.presentJoke(response: any())).thenDoNothing()
        }
        
        stub(mockWorker) { stub in
            when(stub.getRandomJokeFor(category: any())).then { _ -> Promise<Joke.Response> in
                let response = Joke.Response(
                    id: "1",
                    phrase: "a-valid-phrase",
                    jokeUrl: "a-valid-joke-url",
                    iconImageUrl: "a-valid-joke-url",
                    createdAt: "a-valid-data",
                    updatedAt: "a-valid-data"
                )
                return .value(response)
            }
        }
        
        sut.presenter = mockPresenter
        sut.requestRandomJoke()
        
        verify(mockPresenter, times(1)).presentFilledState()
        verify(mockPresenter, times(1)).presentJoke(response: any())
    }
    
    func testRequestRandomJokeFailure() {
        let mockPresenter = MockJokePresenter()
        
        stub(mockPresenter) { when($0.presentError(any())).thenDoNothing() }
        stub(mockWorker) { stub in
            when(stub.getRandomJokeFor(category: any())).then { _ -> Promise<Joke.Response> in
                return Promise<Joke.Response> { $0.reject(NetworkError.mappingError) }
            }
        }
        
        sut.presenter = mockPresenter
        sut.requestRandomJoke()
        
        verify(mockPresenter, times(1)).presentError(any())
    }
    
    func testOpenJokeUrl() {
        let mockPresenter = MockJokePresenter()
        
        stub(mockPresenter) { when($0.presentJokePageBy(url: any())).thenDoNothing() }
        
        sut.presenter = mockPresenter
        sut.requestOpenJokePage()
        
        verify(mockPresenter, times(1)).presentJokePageBy(url: any())
    }

    override func tearDown() {
        super.tearDown()
        mockWorker = nil
        sut = nil
    }

}
