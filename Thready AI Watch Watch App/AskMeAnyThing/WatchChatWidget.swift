//
//  WatchChatWidget.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/15/23.
//

import SwiftUI

struct WatchChatWidget: View {
    
    let message: MessageRow
    let retryCallback: (MessageRow) -> Void
    @Binding var isSpeaking:Bool
    let speakingActionTapped:(()->Void)?
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            
            
            messageRowContent(text: message.sendText, messageTypeEnum: .person)
            
            
            if !message.isInteractingWithChatGPT  {
                messageRowContent(
                    text: message.responseText ?? "" ,
                    responseError: message.responseError,
                    showDotLoading: message.isInteractingWithChatGPT,
                    messageTypeEnum: .bot)
            }
            
            
            
            if message.isInteractingWithChatGPT {
                getLoadingGif()
            }
            
            
        }.padding(.bottom,10)
    }
    
    
    @ViewBuilder
    func messageRowContent(text: String, responseError: String? = nil, showDotLoading: Bool = false, messageTypeEnum:MessageTypeEnum) -> some View {
        
        let screenWidth = WKInterfaceDevice.current().screenBounds.width
        
        VStack(alignment: .leading, spacing: 10) {
            
            if !text.isEmpty {
                Text(text)
                    .foregroundColor(messageTypeEnum == .person ? Color.black : Color.white)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .shadow(color: messageTypeEnum == .person ? .white : .clear, radius: 2, x: 1, y: 1)
            }
            
            if let error = responseError {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)

                Button("Regenerate response") {
                    retryCallback(message)
                }
                .font(.system(size: 12))
                .foregroundColor(.blue)
                .frame(height: 40)
                .foregroundColor(.accentColor)
                .buttonStyle(PlainButtonStyle())
            }
            
            if messageTypeEnum == .bot{
                getShareAndListenWidget()
            }
            
            
            
            
        }
        
        .padding()
        .frame(width: screenWidth)
        .frame(minHeight: 30)
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
            .cornerRadius(5)
        
    }
    
    
    func getLoadingGif()-> some View{
        
        HStack{
            Spacer()
            
            GifImageWatch()
                .frame(width: 100, height: 100)
                .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
            
            Spacer()
            
        }
        
    }
    
    
    
    func getShareAndListenWidget()-> some View{
        HStack(spacing: 10) {
            
            ShareLink(item: message.responseText ?? "") {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
            }
            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .frame(height: 30)
            .cornerRadius(3)
            
            
            
            
//            Button(action: {
//                speakingActionTapped?()
//                
//            }) {
//                Image(systemName: isSpeaking ? "speaker.wave.3.fill" : "speaker.slash.fill")
//                    .foregroundColor(.white)
//            }
//            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
//            .frame(height: 30)
//            .cornerRadius(3)
            
        }
            
    }
    

   


    
    
    
    
}


struct WatchChatWidget_Previews: PreviewProvider {
    
    static let message = MessageRow(
        isInteractingWithChatGPT: true, sendImage: "profile",
        sendText: "What is SwiftUI?",
        responseImage: Image(""), responseImageUrl: "",
        responseText: "SwiftUI is a user interface framework that allows developers to design and develop user interfaces for iOS, macOS, watchOS, and tvOS applications using Swift, a programming language developed by Apple Inc.")
    
    static let message2 = MessageRow(
        isInteractingWithChatGPT: false, sendImage: "profile",
        sendText: "What is SwiftUI?",
        responseImage: Image(""), responseImageUrl: "",
        responseText: "swift is here")
    
    
    static var previews: some View {
        NavigationStack {
            ScrollView {
                WatchChatWidget(message: message, retryCallback: { messageRow in

                }, isSpeaking: .constant(true), speakingActionTapped: nil)

                
                WatchChatWidget(message: message2, retryCallback: { messageRow in
                    
                }, isSpeaking: .constant(true), speakingActionTapped: nil)
                
            }
        }
    }
}








