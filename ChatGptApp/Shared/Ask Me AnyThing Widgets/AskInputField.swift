//
//  AskInputField.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/10/23.
//


// AskInputField

// AskInputField_Previews

import SwiftUI

@available(watchOS 8.0, *)
struct AskInputField: View {
    
    @Binding var askMeInput: String
    @Binding var isInteractingWithChatGPT:Bool
    @FocusState var isTextFieldFocused: Bool
    @Binding var isListening:Bool
    @Binding var isChatAi:Bool
    var isMessageEmpty: Bool
    var sendTapped:(()->Void)?
    var settingsTapped:(()->Void)?
    var personaTapped:(()->Void)?
    var recordTapped:(()->Void)?
    
    let isWatchOS = currentPlatform == .watchOS
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    
    var body: some View{
        
        if isWatchOS {
            
            
            VStack(spacing: isMessageEmpty ? 20 : 10) {
                if isMessageEmpty {
                    ZStack{
                        getGifIcon()
                        HStack(alignment: .top,spacing: 5){
                            personaIcon()
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.clear)
                            
                            
                            getSettingButton()
                            
                            
                        }
                    }
                    
                   
                }
                
                HStack(alignment: isWatchOS ? .center : .bottom, spacing: 10) {
                    getTextInputTextField()
                    if !askMeInput.isEmpty {
                        sendBtn()
                            .transition(AnyTransition.opacity.animation(.linear(duration: 0.3)))
                    }
                    
                }
                
            }
            
            
            
        }else{
            
            
            VStack(spacing: isMessageEmpty ? 0 : 100) {
                if isMessageEmpty {
                    
                    HStack(alignment:.top,spacing: 15){
                        if isChatAi {
                            personaIcon()
                        }
                        getGifIcon()
                        getSettingButton()
                    }.padding(.bottom,20)
                   
                }
                
                HStack(alignment: .center, spacing: 10) {
                    getTextInputTextField()
                    if !askMeInput.isEmpty {
                        sendBtn()
                            .transition(AnyTransition.opacity.animation(.linear(duration: 0.3)))
                    }
                    
                    if askMeInput.isEmpty || isListening {
                        micIcon()
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    

    
    
    func getTextInputTextField() -> AnyView{
        
        if isWatchOS{
            
            return AnyView(
                TextField(isMessageEmpty ?  "Ask Me Anything" : "Reply", text: $askMeInput, axis: .vertical)
                    .foregroundColor(.white)
                    .accentColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 10, weight: .bold))
                    .colorScheme(.dark)
                    .opacity(1)
                    .disabled(isInteractingWithChatGPT)
                    .frame(height: 20) // set the height to 20 pixels
                    .onSubmit {
                        sendTapped?()
                    }
            )
            
            
        }else{
            
            return AnyView(
                
                TextField(isMessageEmpty ?  getPlaceholderText() : getReplyPlaceholderText(), text: $askMeInput, axis: .vertical)
                    .focused($isTextFieldFocused)
                    .lineLimit(1...5)
                    .padding(10)
                    .foregroundColor(.white)
                    .accentColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 18, weight: .bold))
                    .colorScheme(.dark)
                    .opacity(1)
                    .disabled(isInteractingWithChatGPT)
                    .frame(minHeight: 50)
                    .background(Color.TEXTFIELDBGCOLOR)
                    .cornerRadius(8)
                    
                

                
                
            )
            
            
            
            
        }
        
        
    }
    
    func getPlaceholderText()->String {
        return isChatAi ? "Ask Me Anything" : "Type to generate an image"
    }
    func getReplyPlaceholderText()->String {
        return isChatAi ? "Reply" : "Type to generate an image"
    }
    func sendBtn() -> AnyView {
        if isWatchOS {
            return AnyView(Text(""))
        }
        else{
            
            return AnyView(
                
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.getCurrentColor(PRIMARYCOLORVALUE))
                        .frame(width: 50,height: 50)
                    
                    Button {
                        sendTapped?()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .bold))
                    }
                    
                }
                
                
            )
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    func getGifIcon() -> some View{
        
        #if os(iOS)
        // For iOS (mobile)
        GifImageMobile("smiling")
            .frame(width: 100, height: 100)
            .border(Color.black)
        
        #elseif os(watchOS)
        GifImageWatch()

        
        #else
        Text("Unsupported platform")
        #endif
        
        
    }
    
    
    func personaIcon()-> some View{
#if os(iOS)
        
        Image(systemName: "person.badge.clock")
            .resizable()
            .frame(width: 40,height: 40)
            .foregroundColor(.white)
            .onTapGesture {
                personaTapped?()
            }
        
#elseif os(watchOS)
        
        Image(systemName: "person.badge.clock")
            .resizable()
            .frame(width: 20,height: 20)
            .foregroundColor(.white)
            .onTapGesture {
                personaTapped?()
            }
        
        
#else
        Text("Unsupported platform")
#endif
        
        
    }
    
    func micIcon()-> some View{
#if os(iOS)
        
        Image(systemName: "mic.circle")
            .resizable()
            .frame(width: 40,height: 40)
            .foregroundColor(.white)
            .onTapGesture {
                recordTapped?()
            }
        
#elseif os(watchOS)
        
        Image(systemName: "mic.circle")
            .resizable()
            .frame(width: 20,height: 20)
            .foregroundColor(.white)
            .onTapGesture {
                recordTapped?()
            }
        
        
#else
        Text("Unsupported platform")
#endif
        
        
    }
    
    
    
    func getSettingButton()-> some View{
        Button {
            settingsTapped?()
        } label: {
            
            
#if os(iOS)
            
            Image(systemName: "gearshape.fill")
                .foregroundColor(.white)
                .font(.system(size: 30))
            
#elseif os(watchOS)
            
            Image(systemName: "gearshape.fill")
                .foregroundColor(.white)
                .font(.system(size: 15))
            
            
#else
            Text("Unsupported platform")
#endif
            
            
            
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}




