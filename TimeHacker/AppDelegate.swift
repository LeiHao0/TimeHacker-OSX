//
//  AppDelegate.swift
//  TimeHacker
//
//  Created by Art on 12/13/15.
//  Copyright © 2015 Art. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    @IBOutlet var statusMenu: NSMenu!
    @IBOutlet var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
        statusItem.menu = statusMenu
        statusItem.title = "TH"
        statusItem.highlightMode = true
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

