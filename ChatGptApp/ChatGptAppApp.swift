//
//  ChatGptAppApp.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/9/23.
//

import SwiftUI
import GoogleMobileAds
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseAnalytics

@main
struct ChatGptAppApp: App {
    
    @AppStorage(APIKEYVALUE) private var ApiKeyValue:String = ""
    @AppStorage(PURCHASEDSTATUSLIFETIME) private var purchaseStatusLifeTime:Int = 0
    @AppStorage(PURCHASEDSTATUSMONTHLY) private var purchasedStatusMonthly:Int = 0
    @AppStorage(ENABLESPEECHSERDEFAULT) private var isSpeechEnabled = true
    @StateObject var apiCallModel = ApiKeyViewModel()
    
    
    init() {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        checkLifeTimePurchasing()
        checkMonthlyPurchasing()
        Analytics.logEvent("LaunchApp", parameters: ["App Name": "ThreadA1"])
    }
    
    
    var body: some Scene {
        WindowGroup {
            if apiCallModel.isApiCall {
                if purchasedStatusMonthly == 1 {
                    AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled))
                        .preferredColorScheme(.light) // set the preferred color scheme to light
                } else if !ApiKeyValue.isEmpty {
                    AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled))
                        .preferredColorScheme(.light) // set the preferred color scheme to light
                } else {
                    AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled))
                        .preferredColorScheme(.light) // set the preferred color scheme to light
                }
            }
        }
    }
    
    
    
    
    func checkLifeTimePurchasing(){
        let status = NonConsumablePurchaseManager.shared.hasPurchasedProduct(lifeTimeAIPId)
        print("life time status ",status)
        if status {
            purchaseStatusLifeTime = 1
        }else{
            purchaseStatusLifeTime = 0
        }
    }
    
    
    func checkMonthlyPurchasing(){
        let subscriptionManager = SubscriptionManager(productIDs: [monthlyAIPId])
        let status = subscriptionManager.checkSubscriptionStatus()
        if status {
            purchasedStatusMonthly = 1
        }else{
            purchasedStatusMonthly = 0
        }
        print("monhtly Status ", status)
        print("purchasedStatusMonthly ",purchasedStatusMonthly)
    }
    
    func getApi_Key() {
        //apiCall = false
        let firebaseDatabaseRef = Database.database().reference()
        print(Thread.isMainThread)
            firebaseDatabaseRef.child("result").observeSingleEvent(of: .value, with: { (snapshot) in
                print("ankush",snapshot)
                ///apiCall = true
                print(Thread.isMainThread)
                let value = snapshot.value as? [String:Any]
                if let key = value?["api_key"] as? String {
                    internalApiKey = key
                }
                
            })
    }
    
}




class ApiKeyViewModel: ObservableObject
{
    @Published var isApiCall = false
    init() {
        getApi_Key()
    }
    
    func getApi_Key() {
        let userDefaults = UserDefaults(suiteName: "group.Com.jeanpaul.mikeyaiassistant")

        print(userDefaults?.string(forKey: "apiKey"))

        isApiCall = false
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            internalApiKey = apiKey.trimmingCharacters(in: CharacterSet(charactersIn: "\"\\"))
        }
        let firebaseDatabaseRef = Database.database().reference()
        print(Thread.isMainThread)
        firebaseDatabaseRef.child("result").observeSingleEvent(of: .value, with: { (snapshot) in
            print("ankush",snapshot)
            self.isApiCall = true
            print(Thread.isMainThread)
            let value = snapshot.value as? [String:Any]
            if let key = value?["api_key"] as? String {
                internalApiKey = key
                WatchConnector.shared.sendDataToWatch(internalApiKey)
                print(userDefaults?.string(forKey: "apiKey"))
                userDefaults?.set(internalApiKey, forKey: "apiKey")
                userDefaults?.synchronize()
            }
            
        })
    }
}
