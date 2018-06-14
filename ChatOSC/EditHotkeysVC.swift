//
//  EditHotkeysVC.swift
//  ChatOSC
//
//  Created by Tom Davis on 13/06/2018.
//  Copyright © 2018 Tom Davis. All rights reserved.
//

import Cocoa

class EditHotkeysVC: NSViewController {

    @IBAction func cancelClicked(_ sender: Any) {
        self.view.window?.close()
    }
    
    @IBOutlet var fldHotkey1: NSTextField!
    @IBOutlet var fldHotkey2: NSTextField!
    @IBOutlet var fldHotkey3: NSTextField!
    @IBOutlet var fldHotkey4: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.window?.title = "Hotkeys"
        
        
    }
    
}
