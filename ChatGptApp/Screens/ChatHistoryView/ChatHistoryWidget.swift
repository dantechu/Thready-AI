//
//  ChatHistorywidget.swift
//  Thready AI
//
//  Created by Ankush Dhawan on 30/01/24.
//

import SwiftUI
struct ChatHistorywidget: View {
    
    let message: ChatHistory
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    private let personTitle = "You"
    private let botTitle = "Thready"
    
    
    
    var body: some View {
        VStack(spacing: 10) {
            messageRowContent(text: message.sendText ?? "", messageTypeEnum: .person)
            if !message.isInteractingWithChatGPT  {
                messageRowContent(
                    text: message.responseText ?? "" ,
                    responseError: message.responseError,
                    showDotLoading: message.isInteractingWithChatGPT,
                    messageTypeEnum: .bot)
            }
        }.padding(.bottom,10)
    }
    
    
    @ViewBuilder
    func messageRowContent(text: String, responseError: String? = nil, showDotLoading: Bool = false, messageTypeEnum:MessageTypeEnum) -> some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(messageTypeEnum == .person ? personTitle : botTitle)
                    .foregroundColor(messageTypeEnum == .person ? Color.PERSONTITLECOLOR : Color.BOTTITLECOLOR)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)

                Spacer()
                
                getMenu(messageTypeEnum: messageTypeEnum,responseError: responseError)
            }
            
            if !text.isEmpty {
                Text(text)
                    .foregroundColor(messageTypeEnum == .person ? Color.black : Color.white)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .shadow(color: messageTypeEnum == .person ? .white : .clear, radius: 2, x: 1, y: 1)
            }
            
            if let error = responseError {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
            }
            
            
        }
        .padding()
        .background(

                messageTypeEnum == .person ?
                LinearGradient(
                    gradient: Gradient(colors: [Color.getCurrentColor(PRIMARYCOLORVALUE), Color.getCurrentColor(PRIMARYCOLORVALUE)]),
                    startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(
                        gradient: Gradient(colors: [Color.BOTREPLYCOLOR]),
                        startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(10)
            .padding(.horizontal,15)
    }
    
}


extension ChatHistorywidget{    
    func getMenu(messageTypeEnum:MessageTypeEnum, responseError: String? = nil) -> AnyView{
        
        if responseError != nil {
            return AnyView(Text(""))
        }
        
        return AnyView(
         Menu {
             ShareLink(item: URL(string: "www.ThreadAI.com")!, subject: Text("Chat AI"), message: Text( (messageTypeEnum == .bot ? message.responseText : message.sendText) ?? "")) {
                 Label("Share...", systemImage: "square.and.arrow.up")
             }

         } label: {
             Image(systemName: "ellipsis")
                 .foregroundColor(messageTypeEnum == .person ? Color.black : Color.white)
                 .font(.title2)
                 .padding(10)
         }
        
        )
        
        
        
    }
    
    func shareText(_ text: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        let avc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        rootViewController.present(avc, animated: true, completion: nil)
    }

    
    func getLoadingGif()-> some View{
        
        HStack{
            Spacer()
            
            GifImageMobile("smiling")
                .frame(width: 200, height: 200)
                .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
            
            Spacer()
            
        }
        
    }
    
    
    
}



struct ChatHistorywidget_Previews: PreviewProvider {
    
    static let message = MessageRow(
        isInteractingWithChatGPT: true, sendImage: "profile",
        sendText: "What is SwiftUI?",
        responseImage: Image(""),
        responseText: "SwiftUI is a user interface framework that allows developers to design and develop user interfaces for iOS, macOS, watchOS, and tvOS applications using Swift, a programming language developed by Apple Inc.")
    
    static let message2 = MessageRow(
        isInteractingWithChatGPT: false, sendImage: "profile",
        sendText: "What is SwiftUI?",
        responseImage:  Image(""),
        responseText: "swift is here")
    
    static var previews: some View {
        NavigationStack {
            ScrollView {
                ChatWidget(message: message, retryCallback: { messageRow in
                    
                }, editTapped: nil, speakingActionTapped: nil, isSpeaking: .constant(true))
                
                ChatWidget(message: message2, retryCallback: { messageRow in
                    
                }, editTapped: nil, speakingActionTapped: nil, isSpeaking: .constant(true))
                
            }
        }
    }
}


