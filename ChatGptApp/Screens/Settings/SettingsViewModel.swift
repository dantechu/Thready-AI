//
//  SettingsViewModel.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/23/23.
//

import Foundation
import MessageUI
import StoreKit


class SettingsViewModel{
    
    func sendEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            print("Error: Email cannot be sent")
            return
        }
        
        let mail = MFMailComposeViewController()
        mail.setToRecipients(["dante@amazingelearning.com"])
        mail.setSubject("Issue in $")
        mail.setMessageBody("", isHTML: false)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            print("Error: No key window found")
            return
        }
        
        window.rootViewController?.present(mail, animated: true)
    }
    
    func openURL(_ url: URL?) {
        guard let url = url else {
            print("Error: Invalid URL")
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Error: Cannot open URL")
        }
    }
    
    
    func rateApp() {
        if let url = URL(string: "https://apps.apple.com/pk/app/thready-ai-assistant/id6448715900") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    

}
