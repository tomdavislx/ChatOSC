//
//  ViewController.swift
//  ChatOSC
//
//  Created by Tom Davis on 06/06/2018.
//  Copyright © 2018 Tom Davis. All rights reserved.
//

import Cocoa
import OSCKit

class ViewController: NSViewController, NSTextFieldDelegate {
    
    var sendString :String = ""
    var messageHistory: String = ""
    
    // These values should get updated immediately on view load, from UserDefaults
    var hotkeys: [String] = [
        "1",
        "2",
        "3",
        "4'"
    ]
    
    @IBOutlet var labelConnectionStatus: NSTextField!
    @IBOutlet var labelConsoleIP: NSTextField!
    @IBOutlet var txtFldMessageHistory: NSTextField!
    @IBOutlet var txtFldMessageText: NSTextField!
    @IBOutlet var txtFldEosOutput: NSTextField!
    @IBOutlet var labelCharacterCount: NSTextField!
    @IBOutlet var buttonSend: NSButton!
    
    // Hotkey button outlets
    @IBOutlet weak var btnHotkey1: NSButton!
    @IBOutlet weak var btnHotkey2: NSButton!
    @IBOutlet weak var btnHotkey3: NSButton!
    @IBOutlet weak var btnHotkey4: NSButton!
    
    @IBAction func buttonEditClicked(_ sender: Any) {
    }
    
    @IBAction func btnHotkey1Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkeys[0])
    }
    @IBAction func btnHotkey2Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkeys[1])
    }
    @IBAction func btnHotkey3Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkeys[2])
    }
    @IBAction func btnHotkey4Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkeys[3])
    }
    
    @IBAction func buttonSendClicked(_ sender: Any) {
        
        sendString = txtFldMessageText.stringValue
        parseMessage(messageToSend: sendString)
        
    }
    
    @IBAction func buttonConnectClicked(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtFldEosOutput.stringValue = ""
        buttonSend.isEnabled = false
        
        // Subscribe to UserDefault "hotkeys" to update button text on change
        UserDefaults.standard.addObserver(self, forKeyPath: "hotkeys", options: .new, context: nil)
        
        // Load hotkey text values manually for the first time
        updateHotkeysText()
    }
    
    deinit {
        // Remove the user default observer
        UserDefaults.standard.removeObserver(self, forKeyPath: "hotkeys")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "hotkeys" {
            updateHotkeysText()
        }
    }
    
    func updateHotkeysText() {
        // Update the hotkeys with values from the user defaults
        if let hotkeys = UserDefaults.standard.stringArray(forKey: "hotkeys") {
            self.hotkeys = hotkeys
            
            btnHotkey1.title = hotkeys[0]
            btnHotkey2.title = hotkeys[1]
            btnHotkey3.title = hotkeys[2]
            btnHotkey4.title = hotkeys[3]
        } else {
            NSLog("Warning: could not load hotkey defaults")
        }
    }
    
    func parseMessage(messageToSend: String) {
        
        if !messageToSend.isEmpty {
            
            switch messageToSend {
            case "/clearlog" :
                print(messageToSend)
                print("Clearing Messageboard")
                clearMessageHistory()
            case "/clear" :
                print(messageToSend)
                sendToEos(message: "")
            case "/macbeth" :
                print (messageToSend)
                clearMessageHistory()
                txtFldMessageHistory.stringValue = "THE THEATRE"
                sendToEos(message: "THE THEATRE")
            case "/fab" :
                print (messageToSend)
                clearMessageHistory()
                txtFldMessageHistory.stringValue = "THUNDERBOYS ARE GO"
                sendToEos(message: "THUNDERBOYS ARE GO")
            case "/quit" :
                sendToEos(message: "ChatOSC Disconnected")
                view.window?.close()
            default:
                print(messageToSend)
                let history = txtFldMessageHistory.stringValue
                sendToEos(message: messageToSend)
                if history.isEmpty {
                    txtFldMessageHistory.stringValue.append(messageToSend)
                } else {
                    txtFldMessageHistory.stringValue.append("\n\(messageToSend)")
                }
            }
        } else {
            print("Error:- Blank message")
        }
        clearMessageField()
    }
    
    func sendToEos(message: String) {
        txtFldEosOutput.stringValue = message
    }
    
    func clearMessageField () {
        txtFldMessageText.stringValue = ""
        labelCharacterCount.stringValue = "0/70"
        buttonSend.isEnabled = false
    }
    
    func clearMessageHistory () {
        txtFldMessageHistory.stringValue = ""
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        let characterCount = self.txtFldMessageText.stringValue.count
        print(characterCount)
        labelCharacterCount.stringValue = "\(String(characterCount))/70"
        buttonSend.isEnabled = true
        
        if characterCount >= 70 {
            self.txtFldMessageText.stringValue = String(self.txtFldMessageText.stringValue.dropLast())
        }
        if characterCount == 0 {
            buttonSend.isEnabled = false
        }
    }
    
}

