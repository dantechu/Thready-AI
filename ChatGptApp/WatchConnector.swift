//
//  WatchConnector.swift
//  Thready AI
//
//  Created by Ankush Dhawan on 24/01/24.
//

import Foundation
import WatchConnectivity
import UIKit
class WatchConnector:NSObject {
        
    static let shared = WatchConnector()

    public let session = WCSession.default
         
    private override init(){
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    func setup() {
        
    }
}


extension WatchConnector:WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        session.activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
            print("sdsd")
            sendDataToWatch(internalApiKey)
            guard let purchase = UserDefaults.standard.value(forKey: "subscriptionPurchase") as? Date else { return  }
            sendSubscriptionDataToWatch(purchase)
        }
        if let error = error {
            print("session activation failed with error: \(error.localizedDescription)")
            return
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print(userInfo)
        //dataReceivedFromWatch(userInfo)
    }
    
    // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        //dataReceivedFromWatch(message)
        print(message)
        //UserDefaults.standard.set("Dhawan", forKey: "pass")
    }
    
}


// MARK: - send data to watch
extension WatchConnector {
    
    public func sendDataToWatch(_ key:String) {
        let dict:[String:Any] = ["data":key]
        
        session.transferUserInfo(dict)
        // for testing in simulator we use
        session.sendMessage(dict, replyHandler: nil, errorHandler: { error in
          print("Error when sending message: \(error.localizedDescription)")
        })
       // session.sendMessage(dict, replyHandler: nil)
    }
    
    public func sendSubscriptionDataToWatch(_ date:Date) {
        let dict:[String:Any] = ["data":date]
        
        session.transferUserInfo(dict)
        // for testing in simulator we use
        session.sendMessage(dict, replyHandler: nil, errorHandler: { error in
          print("Error when sending message: \(error.localizedDescription)")
        })
       // session.sendMessage(dict, replyHandler: nil)
    }
}

// MARK: - receive data
extension WatchConnector {
    
    public func dataReceivedFromWatch(_ info:[String:Any]) {
        let key = info["data"] as! String
    }
}
