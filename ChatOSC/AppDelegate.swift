//
//  AppDelegate.swift
//  ChatOSC
//
//  Created by Tom Davis on 06/06/2018.
//  Copyright © 2018 Tom Davis. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // Default settings if no user defaults are found
    let defaultSettings = [
        "hotkeys": [
            "Test 1",
            "Test 2",
            "Test 3",
            "Test 4"
        ]
    ]

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        UserDefaults.standard.register(defaults: defaultSettings)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

