//
//  ContentView.swift
//  SlidingIntroScreen
//
//  Created by Federico on 18/03/2022.
//

import SwiftUI
import SwiftOpenAI
import AVFoundation

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreenView()
    }
}


struct IntroScreenView: View {
    @State private var pageIndex = 0
    @AppStorage(IntroPass) private var isIntroPass = false
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    @State private var showImageGPT = false
    @State private var showSpeechGPT = false
    @State private var showChatView = false
    @State private var chatAI = true
    var apikey:String = ""
    var isSpeechEnabled:Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                if isIntroPass {
                    VStack(spacing: 20) {
                        PageView(page: pages[pages.count - 1])
                        NavigationLink(destination:  AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled, service: OpenAiKeys.getObject()),isChatAi: .constant(false))
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(manager)
                            .environment(\.managedObjectContext, manager.container.viewContext), isActive: $showImageGPT) {
                                Button(action: goToImageGPT) {
                                    HStack {
                                        Label {
                                            Text("Image generator")
                                                .font(.title2)
                                        } icon: {
                                            Image(systemName:"play.circle")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                        }
                                        .frame(width: 260, height: 35)
                                        .padding(12)
                                        .foregroundColor(.white)
                                    }
                                    .background(.yellow,
                                                in: RoundedRectangle(cornerRadius: 12))
                                }
                                
                                
                            }
                        
                        NavigationLink(destination: CreateAudioView(service: OpenAiKeys.getObject())
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(manager)
                            .environment(\.managedObjectContext, manager.container.viewContext), isActive: $showSpeechGPT) {
                                Button(action: goToSpeechGPT) {
                                    HStack {
                                        Label {
                                            Text("Text to speech")
                                                .font(.system(size: 20))
                                        } icon: {
                                            Image(systemName:"play.circle")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                        }
                                        .frame(width: 260, height: 30)
                                        .padding(12)
                                        .foregroundColor(.white)
                                    }
                                    .background(.blue,
                                                in: RoundedRectangle(cornerRadius: 12))
                                }
                                
                                
                            }
                        
                        NavigationLink(destination:  AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled, service: OpenAiKeys.getObject()),isChatAi: .constant(true))
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(manager)
                            .environment(\.managedObjectContext, manager.container.viewContext),isActive: $showChatView) {
                                Button(action:goToChatGPT ) {
                                    HStack {
                                        Label {
                                            Text("AI Chat")
                                                .font(.title2)
                                                .padding(.leading, 25)
                                        } icon: {
                                            Image(systemName:"message")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                        }
                                        .frame(width: 260, height: 35)
                                        .padding(12)
                                        .foregroundColor(.white)
                                    }
                                    .background(.green,
                                                in: RoundedRectangle(cornerRadius: 12))
                                }
                            }
                    }
                }else {
                    TabView(selection: $pageIndex) {
                        ForEach(pages) { page in
                            VStack {
                                Spacer(minLength: 20)
                                PageView(page: page).padding(.bottom, 20)
                                if page == pages.last {
                                    VStack(spacing: 15) {
                                        NavigationLink(destination:  AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled, service: OpenAiKeys.getObject()),isChatAi: .constant(false))
                                            .navigationBarBackButtonHidden(true)
                                            .environmentObject(manager)
                                            .environment(\.managedObjectContext, manager.container.viewContext), isActive: $showImageGPT) {
                                                Button(action: goToImageGPT) {
                                                    HStack {
                                                        Label {
                                                            Text("Image generator")
                                                                .font(.system(size: 20))
                                                        } icon: {
                                                            Image(systemName:"play.circle")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                        }
                                                        .frame(width: 260, height: 30)
                                                        .padding(12)
                                                        .foregroundColor(.white)
                                                    }
                                                    .background(.yellow,
                                                                in: RoundedRectangle(cornerRadius: 12))
                                                }
                                                
                                                
                                            }
                                        
                                        NavigationLink(destination: CreateAudioView(service: OpenAiKeys.getObject())
                                            .navigationBarBackButtonHidden(true)
                                            .environmentObject(manager)
                                            .environment(\.managedObjectContext, manager.container.viewContext), isActive: $showSpeechGPT) {
                                                Button(action: goToSpeechGPT) {
                                                    HStack {
                                                        Label {
                                                            Text("Text to speech")
                                                                .font(.system(size: 20))
                                                        } icon: {
                                                            Image(systemName:"play.circle")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                        }
                                                        .frame(width: 260, height: 30)
                                                        .padding(12)
                                                        .foregroundColor(.white)
                                                    }
                                                    .background(.blue,
                                                                in: RoundedRectangle(cornerRadius: 12))
                                                }
                                                
                                                
                                            }
                                        
                                        NavigationLink(destination:  AskMeAnyThing(vm: AskMeAnyThingViewModel(api: ChatGPTAPI(apiKey: internalApiKey), enableSpeech: isSpeechEnabled, service: OpenAiKeys.getObject()),isChatAi: .constant(true))
                                            .navigationBarBackButtonHidden(true)
                                            .environmentObject(manager)
                                            .environment(\.managedObjectContext, manager.container.viewContext),isActive: $showChatView) {
                                                Button(action:goToChatGPT ) {
                                                    HStack {
                                                        Label {
                                                            Text("AI Chat")
                                                                .font(.system(size: 20))
                                                                .padding(.leading, 25)
                                                        } icon: {
                                                            Image(systemName:"message")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                        }
                                                        .frame(width: 260, height: 30)
                                                        .padding(12)
                                                        .foregroundColor(.white)
                                                    }
                                                    .background(.green,
                                                                in: RoundedRectangle(cornerRadius: 12))
                                                }
                                            }
                                    }
                                    
                                    
                                } else {
                                    Button(action: incrementPage) {
                                        Text("Next").frame(width: 100)
                                    }.buttonStyle(.borderedProminent)
                                        .tint(.green)
                                }
                                Spacer()
                            }
                            .tag(page.tag)
                        }
                    }
                    .animation(.easeInOut, value: pageIndex)// 2
                    .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                    .tabViewStyle(PageTabViewStyle())
                    .onAppear {
                        dotAppearance.currentPageIndicatorTintColor = .white
                        dotAppearance.pageIndicatorTintColor = .gray
                    }
                }
            }.onAppear(perform: {
                checkMicPermission()
            })
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func checkMicPermission()  {
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
                // The user granted access. Present recording interface.
            } else {
                // Present message to user indicating that recording
                // can't be performed until they change their preference
                // under Settings -> Privacy -> Microphone
            }
        }
        }
    
    func goToImageGPT() {
        //pageIndex = 0
        isIntroPass = true
        showImageGPT = true
    }
    
    func goToSpeechGPT() {
        //pageIndex = 0
        isIntroPass = true
        showSpeechGPT = true
    }
    func goToChatGPT() {
        //pageIndex = 0
        isIntroPass = true
        showChatView = true
    }
}
