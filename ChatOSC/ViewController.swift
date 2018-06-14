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
    @IBOutlet var txtFldMessageHistory: NSTextField!
    @IBOutlet var txtFldMessageText: NSTextField!
    
    @IBAction func buttonEditClicked(_ sender: Any) {
    }
    
    @IBAction func btnHotkey1Clicked(_ sender: Any) {
        sendHotkey(hk: "hk1")
    }
    @IBAction func btnHotkey2Clicked(_ sender: Any) {
        sendHotkey(hk: "hk2")
    }
    @IBAction func btnHotkey3Clicked(_ sender: Any) {
        sendHotkey(hk: "hk3")
    }
    @IBAction func btnHotkey4Clicked(_ sender: Any) {
        sendHotkey(hk: "hk4")
    }
    @IBAction func buttonSendClicked(_ sender: Any) {
        
        sendString = txtFldMessageText.stringValue
        
        if sendString != "" {
        
            txtFldMessageText.stringValue = ""
        
        switch sendString {
        case "/clear" :
            print (sendString)
            print("Clearing Programmer")
            txtFldMessageHistory.stringValue = ""
        case "/macbeth" :
            print (sendString)
            print("Clearing Programmer")
            txtFldMessageHistory.stringValue = ""
            txtFldMessageHistory.stringValue = "THE THEATRE"
        case "/fab" :
            print (sendString)
            print("Clearing Programmer")
            txtFldMessageHistory.stringValue = ""
            txtFldMessageHistory.stringValue = "THUNDERBOYS ARE GO"
        default:
            
            print(sendString)
            if txtFldMessageHistory.stringValue == "" {
                txtFldMessageHistory.stringValue.append(sendString)
            } else {
                
                txtFldMessageHistory.stringValue.append("\n\(sendString)")
            }
        }
        } else {
            txtFldMessageHistory.stringValue.append("\n ERROR:- Message contents blank")
        }
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
            
            // DOUG TO FIX :)
            
            //            popupVC.fldHotkey1.stringValue = hotkey1
            //            popupVC.fldHotkey2.stringValue = hotkey2
            //            popupVC.fldHotkey3.stringValue = hotkey3
            //            popupVC.fldHotkey4.stringValue = hotkey4
        }
    }
    
    func sendHotkey(hk: String) {
        
        switch hk {
        case "hk1" :
            txtFldMessageHistory.stringValue.append("\n\(hotkey1)")
        case "hk2" :
            txtFldMessageHistory.stringValue.append("\n\(hotkey2)")
        case "hk3" :
            txtFldMessageHistory.stringValue.append("\n\(hotkey3)")
        case "hk4" :
            txtFldMessageHistory.stringValue.append("\n\(hotkey4)")
        default :
            break
        }
    }
}

