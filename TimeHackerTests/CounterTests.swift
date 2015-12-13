//
//  CounterTests.swift
//  TimeHacker
//
//  Created by Art on 12/14/15.
//  Copyright © 2015 Art. All rights reserved.
//

import XCTest

@testable import TimeHacker

class CounterTests: XCTestCase {
    
    class testCounterDelegate: CounterDelegate {
        func timerAction() {
            print("do some actions such as UI...")
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStart() {
        
        let counter = Counter()
        counter.delegate = testCounterDelegate()
        counter.start()
        NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 3))
        
        counter.stop()
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//            
//        }
    }

}

