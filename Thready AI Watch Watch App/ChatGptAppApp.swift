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
    @AppStorage(QUERYCOUNTER) var queryCounter: Int = 0
    @AppStorage(LASTANSWEREDDATE) var lastAnsweredDateString: String = ""
    @AppStorage("apiKey") var apiKey: String = ""

    init(){
        print(apiKey)
        let userDefaults = UserDefaults(suiteName: "group.Com.jeanpaul.mikeyaiassistant")
        internalApiKey = userDefaults?.string(forKey: "apiKey") ?? ""
        if internalApiKey.isEmpty {
            internalApiKey = "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"
        }
        checkMonthlyPurchasing()
        checkRemainingQuery()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey),enableSpeech: true) )
        }
    }
    
    func checkMonthlyPurchasing(){
        let subscriptionManager = SubscriptionManager(productIDs: [monthlySubscriptionAIPIdWatch])
        let status = subscriptionManager.checkSubscriptionStatus()
        if status {
            watchPurchasedStatusMonthly = 1
        }else{
            watchPurchasedStatusMonthly = 0
        }
    }
    
    
    func checkRemainingQuery(){
        
        let calendar = Calendar.current
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if lastAnsweredDateString.isEmpty || dateFormatter.date(from: lastAnsweredDateString) == nil {
            // If lastAnsweredDateString is empty or not a valid date string, assume it's a new day
            lastAnsweredDateString = dateFormatter.string(from: currentDate)
            queryCounter = 3
        } else if let lastAnsweredDate = dateFormatter.date(from: lastAnsweredDateString),
                  !calendar.isDate(currentDate, inSameDayAs: lastAnsweredDate) {
            // Reset the query counter for the new day
            queryCounter = 3
            lastAnsweredDateString = dateFormatter.string(from: currentDate)
        }
        
    }
    
    
    
}




extension Date {
    static func now() -> Date {
        return Date()
    }
}
