//
//  THCalenderTests.swift
//  TimeHacker
//
//  Created by Art on 12/15/15.
//  Copyright © 2015 Art. All rights reserved.
//

import XCTest
@testable import TimeHacker

class THCalenderTests: XCTestCase {
    
    let thCalender = THCalender()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFetchingEvents() {
        // Get the appropriate calendar
        let calendar = NSCalendar.currentCalendar()
        
        // Create the start date components
        let oneDayAgoComponents = NSDateComponents()
        oneDayAgoComponents.day = -1
        
        let oneDayAgo = calendar.dateByAddingComponents(oneDayAgoComponents, toDate: NSDate(), options: .WrapComponents)
        
        // Create the end date components
        let oneMonthFromNowComponents = NSDateComponents()
        oneMonthFromNowComponents.month = 1
        let oneYearFromNow = calendar.dateByAddingComponents(oneMonthFromNowComponents, toDate: NSDate(), options: .WrapComponents)
        
        if let startDate = oneDayAgo, endDate = oneYearFromNow {
            print(thCalender.FetchingEvents(startDate, endDate: endDate))
        }
    }
    
    func testSaveEvent() {
        let event = thCalender.newEvent(("testSaveEvent", NSDate.init(timeIntervalSinceNow: -60*25), NSDate()))
        thCalender.saveEvent(event)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
    }

}
