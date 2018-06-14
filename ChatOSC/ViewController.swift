//
//  ViewController.swift
//  ChatOSC
//
//  Created by Tom Davis on 06/06/2018.
//  Copyright © 2018 Tom Davis. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var sendString :String = ""
    var messageHistory: String = ""
    var hotkey1 :String = "Sample 1"
    var hotkey2 :String = "Sample 2"
    var hotkey3 :String = "Sample 3"
    var hotkey4 :String = "Sample 4"
    
    @IBOutlet var labelConnectionStatus: NSTextField!
    @IBOutlet var labelConsoleIP: NSTextField!
    @IBOutlet var txtFidMessageHistory: NSTextField!
    @IBOutlet var txtFldMessageText: NSTextField!
    
    @IBAction func buttonEditClicked(_ sender: Any) {
    }
    
    @IBAction func buttonSendClicked(_ sender: Any) {
        sendString = txtFldMessageText.stringValue
        txtFldMessageText.stringValue = ""
        print(sendString)
    }
    
    @IBAction func buttonConnectClicked(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded
        }
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier!.rawValue == "hotkeysSegue" {
            let popupVC = segue.destinationController as! EditHotkeysVC
            print (hotkey1)
            popupVC.fldHotkey1.stringValue = hotkey1
            popupVC.fldHotkey2.stringValue = hotkey2
            popupVC.fldHotkey3.stringValue = hotkey3
            popupVC.fldHotkey4.stringValue = hotkey4
        }
    }
}

