//
//  PageModel.swift
//  SlidingIntroScreen
//
//  Created by Federico on 18/03/2022.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "IntroIcon", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Chat AI assistant for iPhone and Apple iWatch", description: "Get full experience of AI chatting, assistant and image generation using the app right from your iphone and iwatches.", imageUrl: "IntroIcon", tag: 0),
        Page(name: "Unlock Advanced Models", description: "Image Generation using GPT-4 (most Advanced AI model) and all future released models!", imageUrl: "IntroIcon", tag: 1),
        Page(name: "Pay as you Go", description: "Just purchase enough points to get start using the all pro features. No need to worry about weekly/monthly subscription.You will get 10 credits to start. After that, just pay as you go.", imageUrl: "IntroIcon", tag: 2),
        Page(name: "Please select the chat type", description: "Image generation chat type will help you to generate image as per user text and chat Ai type will give answer of user queries in the form text", imageUrl: "IntroIcon", tag: 3)
    ]
}
