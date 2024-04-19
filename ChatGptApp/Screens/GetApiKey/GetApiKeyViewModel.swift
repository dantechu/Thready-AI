//
//  GetApiKeyViewModel.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/9/23.
//

import Foundation
import SwiftUI

class GetApiKeyViewModel:ObservableObject{
    
    @Published var isLoading:Bool = false
    @Published var isValidAPIKey:Int = -1
    @AppStorage(APIKEYVALUE) private var ApiKeyValue:String = ""
    
    
    func validateApiKey(_ userInput:String) async{
        let api = ChatGPTAPI(apiKey: userInput)
        let isValidAPIKey = await api.isValidAPIKey()
        
        self.isValidAPIKey = isValidAPIKey ? 1 : 0
        
    }

    

    func saveApiKey(_ userInput:String){
        if isValidAPIKey == 1{
            self.ApiKeyValue = userInput
            GetApiKeyViewModel.saveApiKeyToKeychain(value: userInput, key: "myApiKey")
        }
        
        //        // Retrieve from Keychain
//        if let retrievedValue = GetApiKeyViewModel.getStringFromKeychain() {
//            print("Retrieved value: \(retrievedValue)")
//        } else {
//            print("Value not found in Keychain.")
//        }
    }


    // Function to save a string to the Keychain
    static func saveApiKeyToKeychain(value: String, key: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            // Delete any existing value for this key
            SecItemDelete(query as CFDictionary)

            // Add the new value to the Keychain
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
               // print("Error saving to Keychain: \(status)")
                return
            }
        }
    }


    // Function to retrieve a string from the Keychain
    static func getApiKeyFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "myApiKey",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess else {
           // print("Error retrieving from Keychain: \(status)")
            return nil
        }

        if let retrievedData = dataTypeRef as? Data,
           let result = String(data: retrievedData, encoding: .utf8) {
            return result
        }

        return nil
    }

}


