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
    var hotkey1 :String = "Sample 1"
    var hotkey2 :String = "Sample 2"
    var hotkey3 :String = "Sample 3"
    var hotkey4 :String = "Sample 4"
    
    @IBOutlet var labelConnectionStatus: NSTextField!
    @IBOutlet var labelConsoleIP: NSTextField!
    @IBOutlet var txtFldMessageHistory: NSTextField!
    @IBOutlet var txtFldMessageText: NSTextField!
    @IBOutlet var txtFldEosOutput: NSTextField!
    @IBOutlet var labelCharacterCount: NSTextField!
    @IBOutlet var buttonSend: NSButton!
    
    @IBAction func buttonEditClicked(_ sender: Any) {
    }
    
    @IBAction func btnHotkey1Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkey1)
    }
    @IBAction func btnHotkey2Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkey2)
    }
    @IBAction func btnHotkey3Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkey3)
    }
    @IBAction func btnHotkey4Clicked(_ sender: Any) {
        parseMessage(messageToSend: hotkey4)
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
            
            // DOUG TO FIX :)
            
            //popupVC.fldHotkey1.stringValue = hotkey1
            //popupVC.fldHotkey2.stringValue = hotkey2
            //popupVC.fldHotkey3.stringValue = hotkey3
            //popupVC.fldHotkey4.stringValue = hotkey4
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

