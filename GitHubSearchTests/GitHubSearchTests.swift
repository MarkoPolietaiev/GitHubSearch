//
//  GitHubSearchTests.swift
//  GitHubSearchTests
//
//  Created by Marko Polietaiev on 3/23/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import XCTest
import UIKit
@testable import GitHubSearch

class GitHubSearchTests: XCTestCase {
    
    private var rootViewController: StartViewController!
    private var topLevelUIUtilities: TopLevelUIUtilities<StartViewController>!


    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "StartViewController",  bundle: nil)
        let myViewController = storyboard.instantiateInitialViewController() as? StartViewController
        myViewController!.oldRequests = ["test1", "test2", "test3"]
        rootViewController = myViewController
        topLevelUIUtilities = TopLevelUIUtilities<StartViewController>()
        topLevelUIUtilities.setupTopLevelUI(withViewController: rootViewController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInitRepo() {
        
    }

}
