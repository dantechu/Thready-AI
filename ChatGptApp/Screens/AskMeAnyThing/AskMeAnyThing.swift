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
    @AppStorage(QUERYCOUNTER) var queryCounter: Int = 10
    @State private var showPremiumScreen = false
    @Binding var isChatAi:Bool
    @AppStorage(TOTALSEARCHDONE) private var TOTALSEARCHVALUE:Int = 0
    @AppStorage(PURCHASEDSTATUSLIFETIME) private var purchaseStatusLifeTime:Int = 0
    @AppStorage(PURCHASEDSTATUSMONTHLY) private var purchasedStatusMonthly:Int = 0
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        
        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
            
            VStack {
                HStack {
                    Image(systemName:"house")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .padding([.trailing,.leading],5)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss() 
                    }
                    
                    if purchasedStatusMonthly == 0 && purchaseStatusLifeTime == 0 {
                        Text(String(queryCounter) + " Credit")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                        Spacer()
                    }
                    
                    purchaseProVersionBtn
                    
                }
                
                ChatHeader(messagesCount: vm.messages.count) {
                    shareLastMessage()
                } finishTapped: {
                    saveChatToTable()
                    vm.messages.removeAll()
                }
                
                
                
                chatListView
            }
            
            getFullScreenLoading()
        }
        .onAppear {
           // print(isChatAi)
            loadInterstitial()
//            let key =  KeychainWrapper.standard.string(forKey:"apiKey") ?? ""
//            if !key.isEmpty {
//                WatchConnector.shared.sendDataToWatch(key, queryCounter: queryCounter)
//            }
        }
        .onDisappear {
        }
    }
    
    
    var chatListView: some View {
        ScrollViewReader { proxy in
            
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.messages) { message in
                            ChatWidget(message: message, isChatAi: isChatAi ,retryCallback: { message in
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
                isTextFieldFocused: _isTextFieldFocused, isListening: $isListening,isChatAi: $isChatAi,
                isMessageEmpty: $vm.messages.isEmpty) {
                    self.showAd()
                    if queryCounter == 0 && purchasedStatusMonthly == 0 && purchaseStatusLifeTime == 0 {isPresentingAdRemoveScreen = true;  return }
                    if queryCounter !=  0 {
                        queryCounter -= 1
                    }
                    let key =  KeychainWrapper.standard.string(forKey:"apiKey") ?? ""
                    WatchConnector.shared.sendDataToWatch(key, queryCounter: queryCounter)
                    Task { @MainActor in
                        if isChatAi {
                            await vm.sendTapped()
                        } else {
                            await vm.sendImageTapped()
                        }
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
            Settings().environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
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
    
    func checkPurchaseStatus() -> Int {
       // let subscriptionManager = SubscriptionManager(productIDs: [monthlySubscriptionAIPIdWatch])
       var watchPurchasedStatus = 0
        
        let subscriptionManager = SubscriptionManager(productIDs: [monthlyAIPId, weeklyAIPId, yearlylyAIPId])
        subscriptionManager.restoreProduct { result in
            
        }

        let status3 = subscriptionManager.hasPurchased(productID: monthlyAIPId)
        if status3 {
            watchPurchasedStatus = 1
        }
        let status1 = subscriptionManager.hasPurchased(productID: weeklyAIPId)
        if status1 {
            watchPurchasedStatus = 1
        }
        let status2 = subscriptionManager.hasPurchased(productID: yearlylyAIPId)
        if status2 {
            watchPurchasedStatus = 1
        }
       return watchPurchasedStatus
    }
    
    private func saveChatToTable() {
        vm.messages.forEach { message in
      var  history = ChatHistory(context: self.viewContext)
            history.sendText = message.sendText
            history.sendImage = message.sendImage
            history.chatDate = Date()
            history.isInteractingWithChatGPT =  message.isInteractingWithChatGPT
            history.responseImage = ""
            history.responseText =  message.responseText
            history.responseError = message.responseError
            do {
                try self.viewContext.save()
               // print("Todo saved!")
            } catch {
               // print("whoops \(error.localizedDescription)")
            }
        }
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
               // print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            //print("ready to show")
            self.interstitial = ad
        }
    }
    
    
    func showAd(){
        
        if purchaseStatusLifeTime == 1 || purchasedStatusMonthly == 1 { return }
        if TOTALSEARCHVALUE != 3 { TOTALSEARCHVALUE += 1;  return }
        TOTALSEARCHVALUE = 0
        guard let ad = interstitial else {//print("Interstitial ad not ready");
            return}
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            ad.present(fromRootViewController: rootViewController)
        }
    }
    
}



struct AskMeAnyThing_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: "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")), isChatAi:.constant(true))

        }
    }
}



