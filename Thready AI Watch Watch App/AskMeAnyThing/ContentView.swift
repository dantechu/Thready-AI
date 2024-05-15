//
//  ContentView.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/9/23.
//

import SwiftUI
import OpenAIKit

struct ContentView: View {
    
    @ObservedObject var vm: AskMeAnyThingViewModel
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @AppStorage(WATCHURCHASEDSTATUSMONTHLY) private var watchPurchasedStatusMonthly:Int = 0
    @AppStorage(QUERYCOUNTER) var queryCounter: Int = 10

    @State private var isPresentingSettings = false
    @State private var showButtonSheet = false
    @State private var showDetailsList = false
    @State private var shouldDismissScreens = false
    @State private var showPremiumScreen = false
    @State private var isListening = false
    
    
    var body: some View {
        
        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
            
            
            chatListView
            
            getFullScreenLoading()
            
        }
        .fullScreenCover(isPresented: $showPremiumScreen) {
            ProVersion { showPremiumScreen = false }
        }
        
    }
    
    
    var chatListView: some View {
        
        VStack(spacing: 10) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(vm.messages) { message in
                        
                        
                        WatchChatWidget(message: message, retryCallback: { message in
                            Task { @MainActor in
                                await vm.retry(message: message)
                            }
                            
                        }, isSpeaking: $vm.isSpeaking) {
                            vm.isSpeaking ? vm.stopSpeaking() : vm.speakLastResponse(responseText: message.responseText ?? "")
                        }
                        
                        
                    }
                    
                    
                    if vm.messages.count != 0 && !vm.isInteractingWithChatGPT{
                        getInputWidget()
                    }

                }
            }
            .background(Color.clear)
            
            
            
            if vm.messages.count == 0{ inputField }
            
            
            
        }
    }
    
    
    
    var inputField:some View{
        VStack {
            AskInputField(
                askMeInput: $vm.inputMessage,
                isInteractingWithChatGPT: $vm.isInteractingWithChatGPT,
                isListening: $isListening, isChatAi: .constant(true), isMessageEmpty: $vm.messages.isEmpty) {
                    
                    if queryCounter == 0 && watchPurchasedStatusMonthly == 0 {showPremiumScreen = true;  return }
                    PhoneConnector.shared.sendDataToPhone(queryCounter)
                    Task { @MainActor in
                        await vm.sendTapped()
                    }
                    
            } settingsTapped: {
                isPresentingSettings = true
            } personaTapped: {
                showButtonSheet = true
            }
            
        }
        
        .fullScreenCover(isPresented: $isPresentingSettings) {
            SettingsWatch()
        }
        
        .fullScreenCover(isPresented: $showButtonSheet) {
            
            PersonaList(shouldDismissScreens: $shouldDismissScreens) { selectedCatIndex, selectedItemIndex in
                showButtonSheet = false
                vm.inputMessage = PERSONALIST[selectedCatIndex][selectedItemIndex]
            }
            
        }
        
        
    }
    
    
}


extension ContentView{
    
    
    func getFullScreenLoading()-> AnyView{
        
        if vm.messages.count == 1 && vm.isInteractingWithChatGPT  {
            return AnyView(
                FullScreenLoading()
            )
        }
        return AnyView(Text(""))
    }
    
    
    func getInputWidget()-> some View{

        VStack(spacing: 30){
            getReplyBtn()
            
            getDoneBtn()
        }
        .padding(.top,20)
        
    }
    
    
    
    private func getReplyBtn() -> some View{
        
        
        VStack(spacing: watchPurchasedStatusMonthly == 0 ? 20 : 0){
            
            if watchPurchasedStatusMonthly == 0{
                Text("\(queryCounter) credits left")
            }
            
            
            TextField(vm.messages.isEmpty ? "Ask Me Anything" : "Reply", text: $vm.inputMessage, axis: .vertical)
                .foregroundColor(.white)
                .accentColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                .font(.system(size: 10, weight: .bold))
                .colorScheme(.dark)
                .opacity(1)
                .disabled(vm.isInteractingWithChatGPT)
                .frame(height: 20)
                .onSubmit {
                    
                    if queryCounter == 0 && watchPurchasedStatusMonthly == 0 {showPremiumScreen = true;  return }
                    
                    
                    Task { @MainActor in
                        await vm.sendTapped()
                    }
                }
            
            
            
        }
        
        

        
    }
    
    
    
    private func getDoneBtn() -> some View {
        VStack {
            Button(action: {
                vm.messages.removeAll()
            }) {
                Text("Done")
                    .foregroundColor(Color.white)
                    .font(.system(size: 14,weight: .bold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .cornerRadius(8)
            }
        }
        .background(Color.WATCHBTNCOLOR)
        .frame(height: 30)
        .cornerRadius(5)
    }
    
    

    
}




//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        NavigationStack {
//            ContentView(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: "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")))
//        }
//    }
//}
