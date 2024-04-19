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
import FirebaseFirestore
import CryptoSwift
import OpenAIKit

// Url for encription:https://encode-decode.com/aes-128-ecb-encrypt-online/


@main
struct ChatGptAppApp: App {
    @AppStorage(APIKEYVALUE) private var ApiKeyValue:String = ""
    @AppStorage(PURCHASEDSTATUSLIFETIME) private var purchaseStatusLifeTime:Int = 0
    @AppStorage(PURCHASEDSTATUSMONTHLY) private var purchasedStatusMonthly:Int = 0
    @AppStorage(ENABLESPEECHSERDEFAULT) private var isSpeechEnabled = true
    @StateObject var apiCallModel = ApiKeyViewModel()
    @StateObject private var manager: DataManager = DataManager()

    
    init() {
        isJailbroken()
        print(Bundle.main.path(forResource: "MyCert", ofType: "cer"))
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        //checkLifeTimePurchasing()
        //checkMonthlyPurchasing()
        Analytics.logEvent("LaunchApp", parameters: ["App Name": "ChatA1"])
    }
    
    
    var body: some Scene {
        WindowGroup {
            if apiCallModel.isApiCall {
                IntroScreenView(apikey: internalApiKey, isSpeechEnabled: isSpeechEnabled)
                    .environmentObject(manager)
                    .environment(\.managedObjectContext, manager.container.viewContext)
                
            }else {
                LoaderView()
            }
//            if apiCallModel.isApiCall {
//                if purchasedStatusMonthly == 1 {
//                    AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled))
//                        .environmentObject(manager)
//                        .environment(\.managedObjectContext, manager.container.viewContext)
//                        //.preferredColorScheme(.light) // set the preferred color scheme to light
//                } else if !ApiKeyValue.isEmpty {
//                    AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled))
//                        .environmentObject(manager)
//                        .environment(\.managedObjectContext, manager.container.viewContext)
//                        //.preferredColorScheme(.light) // set the preferred color scheme to light
//                } else {
//                    AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled))
//                        .environmentObject(manager)
//                        .environment(\.managedObjectContext, manager.container.viewContext)
//                        //.preferredColorScheme(.light) // set the preferred color scheme to light
//                }
//            } else {
//                LoaderView()
//            }
        }
    }
    
   
    func checkLifeTimePurchasing(){
        let status = NonConsumablePurchaseManager.shared.hasPurchasedProduct(lifeTimeAIPId)
        //print("life time status ",status)
        NonConsumablePurchaseManager.shared.restorePurchases { success, error in
            if success {
                purchaseStatusLifeTime = 1
            } else {
                purchaseStatusLifeTime = 0

            }
        }
        if status {
            purchaseStatusLifeTime = 1
        }else{
            purchaseStatusLifeTime = 0
        }
    }
    
//    func login() {
//        Auth.auth().signIn(withEmail: "ankush@email.com", password: "welcome") {  authResult, error in
//            if let user = authResult?.user {
//                print(user)
//            } else {
//            }
//        }
//    }
//
    func checkMonthlyPurchasing(){
        let subscriptionManager = SubscriptionManager(productIDs: [monthlyAIPId])
        let status = subscriptionManager.checkSubscriptionStatus()
        subscriptionManager.restoreProduct { result in
            //print(result)
        }
        if status {
            purchasedStatusMonthly = 1
        }else{
            purchasedStatusMonthly = 0
        }
     //   print("monhtly Status ", status)
       // print("purchasedStatusMonthly ",purchasedStatusMonthly)
    }
    
    func getApi_Key() {
        //apiCall = false
        let firebaseDatabaseRef = Database.database().reference()
      //  print(Thread.isMainThread)
            firebaseDatabaseRef.child("result").observeSingleEvent(of: .value, with: { (snapshot) in
                ///apiCall = true
                //print(Thread.isMainThread)
                let value = snapshot.value as? [String:Any]
                if let key = value?["api_key"] as? String {
                    internalApiKey = key
                }
                
            })
    }
    
    func isJailbroken()  {
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") ||
           FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") {
           exit(1)
        }
    }
}




class ApiKeyViewModel: ObservableObject
{
    @Published var isApiCall = false
    init() {
        getApi_Key()
    }
    
    func getApi_Key() {
        //WatchConnector.shared.setup()
        isApiCall = false
        let db = Firestore.firestore()
        db.collection("Result").document("Apikey").getDocument { (document, error) in
            if let document = document {
                let title = document.data()?["Apikey"] as? String ?? ""
                KeychainWrapper.standard.set(title, forKey: "apiKey")
                var counter = UserDefaults.standard.integer(forKey: QUERYCOUNTER)
                WatchConnector.shared.sendDataToWatch(title, queryCounter: counter)
                DispatchQueue.main.async {
                    self.isApiCall = true
                    internalApiKey = self.checkEncription(encriptedValue: title)
                }
            }
        }
    }
    
    func checkEncription(encriptedValue:String) ->String {
        let dValue = try! encriptedValue.aesDecrypt(key: PassKey
            .value)
        return dValue
    }
}

struct LoaderView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                GifImageMobile("smiling")
                    .frame(width: 200, height: 200)
                    .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
                
                Spacer()
            }
            Spacer()
        }.background(Color.black)
    }
}
