//
//  ChatGptAppApp.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/9/23.
//

import SwiftUI


@main
struct ChatGptApp_Watch_AppApp: App {
    @AppStorage(WATCHURCHASEDSTATUSMONTHLY) private var watchPurchasedStatusMonthly:Int = 0
    @AppStorage(QUERYCOUNTER) var queryCounter: Int = 10
    @AppStorage(LASTANSWEREDDATE) var lastAnsweredDateString: String = ""
    @AppStorage("apiKey") var apiKey: String = ""
    @StateObject var apiCallModel = ApiKeyViewModel()

    init(){
        print(apiKey)
        PhoneConnector.shared.setup()
        internalApiKey =  KeychainWrapper.standard.string(forKey:"apiKey") ?? ""
        //checkMonthlyPurchasing()
        checkRemainingQuery()
        checkLifeTimePurchasing()
    }
    
    
    var body: some Scene {
        WindowGroup {
            if apiCallModel.isApiCall {
                ContentView(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey),enableSpeech: true) )
            }else {
                FullScreenLoading()
            }
        }
    }
    
    func checkLifeTimePurchasing(){
        let status = NonConsumablePurchaseManager.shared.hasPurchasedProduct(lifeTimeAIPId)
        print("life time status ",status)
        NonConsumablePurchaseManager.shared.restorePurchases { success, error in
            if success {
                //purchaseStatusLifeTime = 1
                watchPurchasedStatusMonthly = 1

            } else {
                //purchaseStatusLifeTime = 0
                watchPurchasedStatusMonthly = 0


            }
        }
        if status {
            //purchaseStatusLifeTime = 1
            watchPurchasedStatusMonthly = 1

        }else{
            //purchaseStatusLifeTime = 0
            watchPurchasedStatusMonthly = 0

        }
    }
    
    func checkMonthlyPurchasing(){
       // let subscriptionManager = SubscriptionManager(productIDs: [monthlySubscriptionAIPIdWatch])
        watchPurchasedStatusMonthly = 0

        let subscriptionManager = SubscriptionManager(productIDs: [monthlyAIPId, weeklyAIPId, yearlylyAIPId])
        let status = subscriptionManager.checkSubscriptionStatus()
        subscriptionManager.restoreProduct { result in
           print(result)
        }
        if status {
            watchPurchasedStatusMonthly = 1
        }

        let status3 = subscriptionManager.hasPurchased(productID: monthlyAIPId)
//        if status3 {
//            watchPurchasedStatusMonthly = 1
//        }
//        let status1 = subscriptionManager.hasPurchased(productID: weeklyAIPId)
//        if status1 {
//            watchPurchasedStatusMonthly = 1
//        }
//        let status2 = subscriptionManager.hasPurchased(productID: yearlylyAIPId)
//        if status2 {
//            watchPurchasedStatusMonthly = 1
//        }

    }
    
    
    func checkRemainingQuery(){
        
        let calendar = Calendar.current
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if lastAnsweredDateString.isEmpty || dateFormatter.date(from: lastAnsweredDateString) == nil {
            // If lastAnsweredDateString is empty or not a valid date string, assume it's a new day
            lastAnsweredDateString = dateFormatter.string(from: currentDate)
            queryCounter = 10
        } else if let lastAnsweredDate = dateFormatter.date(from: lastAnsweredDateString),
                  !calendar.isDate(currentDate, inSameDayAs: lastAnsweredDate) {
            // Reset the query counter for the new day
            queryCounter = 10
            lastAnsweredDateString = dateFormatter.string(from: currentDate)
        }
        
    }
    
    
    
}




extension Date {
    static func now() -> Date {
        return Date()
    }
}



class ApiKeyViewModel: ObservableObject
{
    @Published var isApiCall = false
    init() {
        getApi_Key()
    }
    
    func getApi_Key() {
//        internalApiKey =  KeychainWrapper.standard.string(forKey:"apiKey") ?? ""
//        if !internalApiKey.isEmpty {
//            isApiCall = true
//            return
//        }
        isApiCall = false
        guard let url = URL(string: "https://v1.nocodeapi.com/ankush/fbsdk/mMdpAUCaOywCYNcF/firestore/allDocuments?collectionName=Result") else {
            isApiCall = true
          return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          if let error = error {
            print(error)
              DispatchQueue.main.async {
                  self.isApiCall = true
              }
            return
          }
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! NSArray
                var dic = json[0] as! [String:Any]
                var valueDic = dic["_fieldsProto"] as! [String:Any]
                var apiDic = valueDic["Apikey"] as! [String:Any]
                var key = apiDic["stringValue"] as? String ?? ""
                DispatchQueue.main.async {
                    internalApiKey = key
                    KeychainWrapper.standard.set(key, forKey: "apiKey")
                    self.isApiCall = true
                }
               } catch {
                   print("error")
               }
        }
        task.resume()
    }
}

