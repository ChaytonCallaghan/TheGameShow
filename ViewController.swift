//
//  ViewController.swift
//  Phidgets_MultipleObjects_Test
//
//  Created by Chayton Callaghan on 2018-10-30.
//  Copyright © 2018 Phidget. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    

    let button0 = DigitalInput() // Red
    let button1 = DigitalInput() // Green
    let ledArray = [DigitalOutput(), DigitalOutput()]
    var isReady = true
    var score1 = 0
    var score2 = 0
    let questionArray = [""]
    var n : Int = 0 // This counts our question array
    
    func attach_handler(sender: Phidget){
        do{
            let hubPort = try sender.getHubPort()
            if(hubPort == 0){
                print("Button 0 Attached")
            }
            else if (hubPort == 1){
                print("Button 1 Attached")
            }
            else if (hubPort == 2){
                print("LED 2 Attached")//red
            }
            else{
                print("LED 3 Attached")
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            
        }
    }
    
    func state_change_button0(sender:DigitalInput, state:Bool){
        
        
        do{
            if(state == true){
                print("Button 0 Pressed")
                
                if(isReady == true){
                    try ledArray[0].setState(true)
                    print("our if statement worked")
                    isReady = false
                    
                    
                }
            }
                else {
                
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            
            
        }
        }
                    
                
        override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            
            try Net.enableServerDiscovery(serverType: .deviceRemote)
           
            try button0.setHubPort(0)
            try button1.setHubPort(1)
            try button0.setIsHubPortDevice(true)
            try button1.setIsHubPortDevice(true)
            
            
            try button0.setDeviceSerialNumber(528048)
            try button0.setHubPort(0)
            try button0.setIsHubPortDevice(true)
            
            try button1.setDeviceSerialNumber(528048)
            try button1.setHubPort(1)
            try button1.setIsHubPortDevice(true)
            
            let _ = button0.stateChange.addHandler(state_change_button0)
            let _ = button1.stateChange.addHandler(state_change_button0)
            
            try button0.open()
            try button1.open()
            
            for i in 0..<ledArray.count{
                try ledArray[i].setDeviceSerialNumber(528048)
                try ledArray[i].setHubPort(i + 2)
                try ledArray[i].setIsHubPortDevice(true)
                let _ = ledArray[i].attach.addHandler(attach_handler)
                try ledArray[i].open()
                
            }
            
            
        }catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        }catch {
        
        }
       
    }


}

