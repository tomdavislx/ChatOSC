//
//  EditHotkeysVC.swift
//  ChatOSC
//
//  Created by Tom Davis on 13/06/2018.
//  Copyright © 2018 Tom Davis. All rights reserved.
//

import Cocoa

class EditHotkeysVC: NSViewController {

    @IBOutlet var fldHotkey1: NSTextField!
    @IBOutlet var fldHotkey2: NSTextField!
    @IBOutlet var fldHotkey3: NSTextField!
    @IBOutlet var fldHotkey4: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the current hotkey values into the fields
        if let hotkeys = UserDefaults.standard.stringArray(forKey: "hotkeys") {
            fldHotkey1.stringValue = hotkeys[0]
            fldHotkey2.stringValue = hotkeys[1]
            fldHotkey3.stringValue = hotkeys[2]
            fldHotkey4.stringValue = hotkeys[3]
        } else {
            NSLog("Warning: could not load hotkey defaults")
        }
    }
    
    override func viewDidAppear() {
        self.view.window?.title = "Hotkeys"
    }
    
    // Dismiss the view controller, ignoring changes
    @IBAction func cancelClicked(_ sender: Any) {
        self.view.window?.close()
    }
    
    // Save the new values to UserDefaults and dismiss the view controller
    @IBAction func btnOkClicked(_ sender: Any) {
        // Collect the new values into an array
        var newHotkeys = [String]()
        newHotkeys.append(fldHotkey1.stringValue)
        newHotkeys.append(fldHotkey2.stringValue)
        newHotkeys.append(fldHotkey3.stringValue)
        newHotkeys.append(fldHotkey4.stringValue)
        
        // Save the new values
        UserDefaults.standard.set(newHotkeys, forKey: "hotkeys")
        
        NSLog("Updated user defaults")
        
        self.view.window?.close()
    }
    
}
