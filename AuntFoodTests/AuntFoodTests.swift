//
//  AuntFoodTests.swift
//  AuntFoodTests
//
//  Created by shouwei on 26/7/15.
//  Copyright (c) 2015 shou. All rights reserved.
//

import UIKit
import XCTest

class AuntFoodTests: XCTestCase {
    
    var list :[String] = []
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.


    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        list  = [String]()
        list.append("a")
        list.append("b")
        XCTAssertEqual(list[0], "a")
        //XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
