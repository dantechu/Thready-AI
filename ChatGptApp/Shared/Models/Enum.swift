//
//  MessageTypeEnum.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/11/23.
//

import Foundation

enum MessageTypeEnum{
    case person
    case bot
    
    
}




enum SettingsItemTypeIphone{
    case apiKey
    case icon
    case enableSpeech
    case volume
    case FAQ
    case leaveReview
    case sendFeedBack
    case bugReport
    case roadmap
    case about
    case chatHistory    
}

enum SettingsItemTypeWatch{
    case unLockChatGPT
    case APIKey
    case icon
    case theme
    case enableSpeech
    case volume
    case about

}





public enum Platform {
    case iOS
    case watchOS
}

public var currentPlatform: Platform {
    #if os(watchOS)
    return .watchOS
    #else
    return .iOS
    #endif
}
