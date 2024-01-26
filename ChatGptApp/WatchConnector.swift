//
//  WatchConnector.swift
//  Thready AI
//
//  Created by Ankush Dhawan on 24/01/24.
//

import Foundation
import WatchConnectivity
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
}


extension WatchConnector:WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        session.activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("session activation failed with error: \(error.localizedDescription)")
            return
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        //dataReceivedFromWatch(userInfo)
    }
    
    // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        //dataReceivedFromWatch(message)
    }
    
}


// MARK: - send data to watch
extension WatchConnector {
    
    public func sendDataToWatch(_ key:String) {
        let dict:[String:Any] = ["data":key]
        
        //session.transferUserInfo(dict)
        // for testing in simulator we use
        session.sendMessage(dict, replyHandler: nil)
    }
}

// MARK: - receive data
extension WatchConnector {
    
    public func dataReceivedFromWatch(_ info:[String:Any]) {
        let key = info["data"] as! String
    }
}
