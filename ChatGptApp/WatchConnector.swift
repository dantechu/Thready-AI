//
//  WatchConnector.swift
//  Thready AI
//
//  Created by Ankush Dhawan on 24/01/24.
//

import Foundation
import WatchConnectivity
import UIKit
import SwiftUI
class WatchConnector:NSObject {
        
    static let shared = WatchConnector()
    @AppStorage(QUERYCOUNTER) var queryCounter: Int = 10

    public let session = WCSession.default
    @AppStorage("passdata") private var data = ""
    private override init(){
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
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
        if activationState == .activated && session.isReachable {
            var counter = UserDefaults.standard.integer(forKey: QUERYCOUNTER)
            sendDataToWatch(internalApiKey, queryCounter: counter)
            guard let purchase = UserDefaults.standard.value(forKey: "subscriptionPurchase") as? Date else { return  }
            sendSubscriptionDataToWatch(purchase)
        }
        if let error = error {
            //print("session activation failed with error: \(error.localizedDescription)")
            return
        }
    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            self.dataReceivedFromWatch(applicationContext)
        }
    }
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        //print(userInfo)
        DispatchQueue.main.async {
            self.dataReceivedFromWatch(userInfo)
        }
    }
    
    // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.dataReceivedFromWatch(message)
        }
        print(message)
        //UserDefaults.standard.set("Dhawan", forKey: "pass")
    }
    
//    func updateApplicationContext(applicationContext: [String : Any]) throws {
//           if WCSession.default.isPaired {
//               do {
//                   try WCSession.default.updateApplicationContext(applicationContext)
//               } catch let error {
//                   throw error
//               }
//           }
//       }

    
}


// MARK: - send data to watch
extension WatchConnector {
    
    public func sendDataToWatch(_ key:String, queryCounter:Int) {
        var  dict = [String:Any]()
        if queryCounter == 0 {
            dict = ["data":key]
        }else {
            dict = ["data":key, "counter": queryCounter]
        }
        guard session.activationState == .activated else {
                /// print("Error attempting to transfer user info: WCSession is not activated")
                  return
        }
        if session.isReachable  {
            session.transferUserInfo(dict)
        }
        if WCSession.isSupported() { //makes sure it's not an iPad or iPod
            if session.isPaired  {
                do {
                    try session.updateApplicationContext(dict)
                } catch let error as NSError {
                    //print(error.description)
                }
            }
        }
        
       // session.sendMessage(dict, replyHandler: nil)
    }
    
    public func sendSubscriptionDataToWatch(_ date:Date) {
        let dict:[String:Any] = ["data":date]
        
        session.transferUserInfo(dict)
        // for testing in simulator we use
        session.sendMessage(dict, replyHandler: nil, errorHandler: { error in
          //print("Error when sending message: \(error.localizedDescription)")
        })
       // session.sendMessage(dict, replyHandler: nil)
    }
}

// MARK: - receive data
extension WatchConnector {
    
    public func dataReceivedFromWatch(_ info:[String:Any]) {
        let counter = info["counter"] as! Int
        queryCounter = counter
    }
}
