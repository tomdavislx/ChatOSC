//
//  SetIPVC.swift
//  ChatOSC
//
//  Created by Tom Davis on 13/06/2018.
//  Copyright © 2018 Tom Davis. All rights reserved.
//

import Cocoa
import OSCKit

class SetIPVC: NSViewController, OSCClientDelegate, OSCPacketDestination {
    
    var remoteIPAddress = "192.168.1.87"

    @IBOutlet var txtFldIPAddress: NSTextField!
    @IBOutlet var popupOSCVersion: NSPopUpButton!
    @IBOutlet var lblConnectionStatus: NSTextField!
    
    @IBAction func btnTestClicked(_ sender: Any) {
        do {
            try client.connect()
            print("Attempting Connection to \(remoteIPAddress)")
            lblConnectionStatus.stringValue = "Connecting..."
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.view.window?.close()
    }
    
    @IBAction func btnOkClicked(_ sender: Any) {
        view.window?.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        createClient()
        interfaces()
        txtFldIPAddress.stringValue = remoteIPAddress
    }
    
    func interfaces() {
        for interface in Interface.allInterfaces() where !interface.isLoopback && interface.family == .ipv4 && interface.isRunning {
            print("*** Network Interface ***")
            print("Display Name: \(interface.displayName)")
            print("Name: \(interface.name)")
            print("IP Address: \(interface.address ?? "")")
            print("Subnet Mask: \(interface.netmask ?? "")")
            print("Broadcast Address: \(interface.broadcastAddress ?? "")")
            print("Display Text: \(interface.displayText)")
        }
    }
    //OSC Connection
    
    let server = OSCServer()
    let client = OSCClient()
    
    func createClient() {
    //client.interface = "en0"
        client.host = remoteIPAddress
        client.port = 3032
        client.useTCP = true
        client.delegate = self
    }
    
    func clientDidConnect(client: OSCClient) {
        print("Client did connect")
        lblConnectionStatus.stringValue = "Connection Successful!"
    }
    
    func clientDidDisconnect(client: OSCClient) {
        print("Client did disconnect")
        lblConnectionStatus.stringValue = "Connection Failed!"
    }
    
    func take(message: OSCMessage) {
        print("Received message - \(message.addressPattern)")
    }
    
    func take(bundle: OSCBundle) {
        print("Received bundle - time tag: \(bundle.timeTag.hex()) elements: \(bundle.elements.count)")
    }
}
