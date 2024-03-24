//
//  PhoneConnectoe.swift
//  Thready AI Watch Watch App
//
//  Created by Ankush Dhawan on 24/01/24.
//

import Foundation
import Foundation
import WatchConnectivity
import SwiftUI

class PhoneConnector:NSObject {
    static let shared = PhoneConnector()
    @AppStorage(QUERYCOUNTER) var queryCounter: Int = 10
    public let session = WCSession.default
    private override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
}

extension PhoneConnector:WCSessionDelegate {
    
   
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("session activation failed with error: \(error.localizedDescription)")
            return
        }
    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            print(applicationContext)
            self.dataReceivedFromPhone(applicationContext)
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print(userInfo)
        DispatchQueue.main.async {
            self.dataReceivedFromPhone(userInfo)
        }
    }
    
    // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.dataReceivedFromPhone(message)
        }
    }
    
}


// MARK: - send data to phone
extension PhoneConnector {
    
    public func sendDataToPhone(_ counter:Int) {
        let dict:[String:Any] = ["counter":counter]
        if session.isReachable  {
            session.transferUserInfo(dict)
            session.sendMessage(dict, replyHandler: nil)
        }
        if WCSession.isSupported() { //makes sure it's not an iPad or iPod
                do {
                    try WCSession.default.updateApplicationContext(dict)
                } catch let error as NSError {
                    print(error.description)
                }
        }
       
    }
    
}

// MARK: - receive data
extension PhoneConnector {
    func setup() {
        
    }
    
    public func dataReceivedFromPhone(_ info:[String:Any]) {
        if let key = info["data"] as? String {
            internalApiKey = checkEncription(encriptedValue: key)//key
            KeychainWrapper.standard.set(key, forKey: "apiKey")
        }else if let date = info["data"] as? Date {
           // UserDefaults.standard.set(date, forKey: "subscriptionPurchase")
        }
        if let counter = info["counter"] as? Int {
            queryCounter = counter
        }
    }
    
    func checkEncription(encriptedValue:String) ->String {
        let key = "%Elearning2024!!"
        let dValue = try! encriptedValue.aesDecrypt(key: key)
        return dValue
    }
}
