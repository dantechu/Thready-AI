//
//  PhoneConnectoe.swift
//  Thready AI Watch Watch App
//
//  Created by Ankush Dhawan on 24/01/24.
//

import Foundation
import WatchConnectivity
class PhoneConnector:NSObject {
        
    static let shared = PhoneConnector()
    
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
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print(userInfo)
        dataReceivedFromPhone(userInfo)
    }
    
    // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        dataReceivedFromPhone(message)
    }
    
}


// MARK: - send data to phone
extension PhoneConnector {
    
    public func sendDataToPhone(_ key:String) {
        let dict:[String:Any] = ["data":key]
        //session.transferUserInfo(dict)
        // for testing in simulator we use
        session.sendMessage(dict, replyHandler: nil)
    }
}

// MARK: - receive data
extension PhoneConnector {
    func setup() {
        
    }
    
    public func dataReceivedFromPhone(_ info:[String:Any]) {
        if let key = info["data"] as? String {
            internalApiKey = key
            KeychainWrapper.standard.set(internalApiKey, forKey: "apiKey")
        }else if let date = info["data"] as? Date {
            UserDefaults.standard.set(date, forKey: "subscriptionPurchase")
        }
    }
}
