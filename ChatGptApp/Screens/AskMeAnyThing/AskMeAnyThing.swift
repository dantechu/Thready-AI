//
//  AskMeAnyThing.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/9/23.
//

import SwiftUI
import GoogleMobileAds

struct AskMeAnyThing: View {
    
    @ObservedObject var vm: AskMeAnyThingViewModel
    @FocusState var isTextFieldFocused:Bool
    @State private var isPresented = false
    @State private var isPresentingSettings = false
    @State private var isPresentingAdRemoveScreen = false
    @State private var showButtonSheet = false
    @State private var isListening = false
    @State var interstitial: GADInterstitialAd?
    
    @AppStorage(TOTALSEARCHDONE) private var TOTALSEARCHVALUE:Int = 0
    @AppStorage(PURCHASEDSTATUSLIFETIME) private var purchaseStatusLifeTime:Int = 0
    @AppStorage(PURCHASEDSTATUSMONTHLY) private var purchasedStatusMonthly:Int = 0
    
    
    
    var body: some View {
        
        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
            
            VStack {

                purchaseProVersionBtn
                
                ChatHeader(messagesCount: vm.messages.count) {
                    shareLastMessage()
                } finishTapped: {
                    vm.messages.removeAll()
                }
                
                
                
                chatListView
            }
            
            getFullScreenLoading()
        }
        .onAppear {
            loadInterstitial()
        }
    }
    
    
    var chatListView: some View {
        ScrollViewReader { proxy in
            
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.messages) { message in
                            
                            ChatWidget(message: message, retryCallback: { message in
                                Task { @MainActor in
                                    await vm.retry(message: message)
                                }
                                
                            }, editTapped: {
                                editTapped(messageValue: message.sendText)
                            }, speakingActionTapped: {
                                vm.isSpeaking ? vm.stopSpeaking() : vm.speakLastResponse(responseText: message.responseText ?? "", synthesizer: .init())
                                
                            }, isSpeaking: $vm.isSpeaking)
                        }

                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                .background(Color.clear)
               
                inputField
                
                
            }
            .onChange(of: vm.messages.last?.responseText) { _ in  scrollToBottom(proxy: proxy)
            }
            
            
        }
        
        
    }
    
    var inputField: some View{
        VStack {
            
            AskInputField(
                askMeInput: $vm.inputMessage,
                isInteractingWithChatGPT: $vm.isInteractingWithChatGPT,
                isTextFieldFocused: _isTextFieldFocused, isListening: $isListening,
                isMessageEmpty: $vm.messages.isEmpty) {
                    self.showAd()
                    Task { @MainActor in
                        await vm.sendTapped()
                    }
                    
                } settingsTapped: {
                    isPresentingSettings = true
                } personaTapped: {
                    showButtonSheet = true
                } recordTapped: {
                    isListening = true
                }
            
        }
        .fullScreenCover(isPresented: $isPresentingSettings) {
            Settings()
        }
        .sheet(isPresented: $showButtonSheet) {
            PersonasList(personaTapped: {selectedCat,selectedItem in
                showButtonSheet = false
                vm.inputMessage = PERSONALIST[selectedCat][selectedItem]
                isTextFieldFocused = true
                
            })
                .presentationDetents([.fraction(0.9)])
            
        }
        
        
    }
    
    
    var purchaseProVersionBtn: some View{
        
        HStack{
            
            Spacer()
            
            
            if purchasedStatusMonthly == 0 && purchaseStatusLifeTime == 0 && vm.messages.isEmpty{
                ZStack {
                    Circle()
                        .foregroundColor(Color.APPERANCEUNSELECTEDBGCOLOR)
                    Image(systemName: "crown.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 50)
                .onTapGesture {
                    moveToPremiumScreen()
                }
                
            }
            
        }
        .padding(.horizontal,20)
        .fullScreenCover(isPresented: $isPresentingAdRemoveScreen) {
            AdsRemoved(crossTapped: {
                isPresentingAdRemoveScreen = false
            })
            
        }
        

    }
    
}




extension AskMeAnyThing{
    
    
    private func moveToPremiumScreen(){
        isPresentingAdRemoveScreen = true
    }
    
    private func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = vm.messages.last?.id else { return }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
    
    
    private func editTapped(messageValue:String){
        vm.inputMessage = messageValue
        isTextFieldFocused = true
        
        
    }
     
    
    func getFullScreenLoading()-> AnyView{
        
        if vm.messages.count == 1 && vm.isInteractingWithChatGPT  {
            return AnyView(
                FullScreenLoading()
            )
        }
        return AnyView(Text(""))
    }
    
    
    func shareLastMessage(){
        let text = vm.messages.last?.responseText ?? ""
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        let avc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        rootViewController.present(avc, animated: true, completion: nil)
        
        
    }
    
    
    
    
}

extension AskMeAnyThing{
    func loadInterstitial() {
        let adRequest = GADRequest()
        GADInterstitialAd.load(withAdUnitID:interstialAdId, request: adRequest) { ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            print("ready to show")
            self.interstitial = ad
        }
    }
    
    
    func showAd(){
        
        if purchaseStatusLifeTime == 1 || purchasedStatusMonthly == 1 { return }
        if TOTALSEARCHVALUE != 3 { TOTALSEARCHVALUE += 1;  return }
        TOTALSEARCHVALUE = 0
        guard let ad = interstitial else {print("Interstitial ad not ready"); return}
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            ad.present(fromRootViewController: rootViewController)
        }
    }
    
}



struct AskMeAnyThing_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: "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")))

        }
    }
}



