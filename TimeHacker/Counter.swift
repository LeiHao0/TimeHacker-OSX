//
//  Counter.swift
//  TimeHacker
//
//  Created by Art on 12/14/15.
//  Copyright © 2015 Art. All rights reserved.
//

import Foundation

protocol CounterDelegate {
    func timerAction()
}

class Counter: NSObject {
    
    var delegate:CounterDelegate?
    
    let startDate: NSDate
    let endDate: NSDate
    
    private let duration = 25.0 * 60
    
    private var timer: NSTimer?
    
    override init() {
        startDate = NSDate()
        endDate = NSDate(timeInterval: self.duration, sinceDate: startDate)
    }
    
    func start() {
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerAction", userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
     func timerAction() {
        if isDebug {
            print(NSDate().timeIntervalSinceDate(startDate))
        }
        
        delegate?.timerAction()
    }
}
