//
//  AppDelegate.swift
//  TimeHarker-OSX
//
//  Created by artwalk on 8/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//


import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var reminderView: NSView!
    @IBOutlet weak var iCalView: NSView!
    @IBOutlet weak var segmentedControl: NSSegmentedControl!
    

    @IBOutlet weak var pomoTaskTextField: NSTextField!
    @IBOutlet weak var pomoStartButton: NSButton!
    @IBOutlet weak var pomoProgressIndicator: NSProgressIndicator!
    @IBOutlet weak var pomoTimeTextField: NSTextField!
    @IBOutlet weak var pomoTimeSlider: NSSlider!
    
    var timer:NSTimer?
    var started = false
    var startDateTime = NSDate()
    
    @IBAction func pomoTimeSliderAction(slider: NSSlider) {
        var i = slider.integerValue
        
        self.pomoTimeTextField.stringValue = String(format: "%02d:00", i%60)
    }
    
    @IBAction func pomoStartBtnAction(sender: NSButton) {
        if started {
            timer?.invalidate()
        } else {
            startDateTime = NSDate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
        }
        
        started = !started
    }
    
    func updateProgress() {
        let interval = NSDate().timeIntervalSinceDate(startDateTime)
        let i = pomoTimeSlider.integerValue*60 - Int(interval)
        let s = String(format: "- %02d:%02d", i/60, i%60)
        
        pomoProgressIndicator.doubleValue = interval/60*100/pomoTimeSlider.doubleValue
        self.pomoTimeTextField.stringValue = s
    }

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        var i = pomoTimeSlider.integerValue
        self.pomoTimeTextField.stringValue = String(format: "%02d:00", i%60)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    @IBAction func segmentedControlAction(sender: NSSegmentedControl) {
        var switcher = sender.selectedSegment == 0 ? false : true
        
        self.showView(switcher)
    }
    
    func showView (switcher:Bool) {
        self.reminderView.hidden = switcher
        self.iCalView.hidden = !switcher
    }
    
}

