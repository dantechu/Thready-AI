//
//  Settings.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/12/23.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    
    init() {
        
        // Set the navigation bar appearance
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        UIBarButtonItem.appearance().tintColor = UIColor(Color.white)
        
    }
    
    
    var body: some View {


        NavigationView {
            scrollList
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Settings")
                            .font(.system(size: 20,weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .navigationBarItems(trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done").foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
                    })
                )
        }
        
    }

    
    
    var scrollList: some View{
        ScrollView {
            LazyVStack(spacing: 0) {
//                Section {
//                    NavigationLink(destination: GetApiKey().navigationBarTitle("API Key"), label: {
//                        SettingsItem(settingsItemType: .apiKey)
//                    })
//
//
//
//                }
                Spacer().frame(height: 40)
                
//                Section {
//
//                    NavigationLink(destination: EmojiSelectection(), label: {
//                        SettingsItem(settingsItemType: .icon)
//                    })
//
//
//
//
//                }
//                Spacer().frame(height: 40)
                
                
                
                Section {
                    SettingsItem(settingsItemType: .enableSpeech)
                    SettingsItem(settingsItemType: .volume)
                    
                }
                Spacer().frame(height: 40)
                
                
                Section {
                    //SettingsItem(settingsItemType: .FAQ)
                    SettingsItem(settingsItemType: .leaveReview)
                    
                    SettingsItem(settingsItemType: .sendFeedBack)
                        
                    
                    
                }
                Spacer().frame(height: 40)
                
                
                Section {
                    //SettingsItem(settingsItemType: .bugReport)
                    //SettingsItem(settingsItemType: .roadmap)
                    
                    NavigationLink(destination: About(), label: {
                        SettingsItem(settingsItemType: .about)
                    })
                    .accentColor(.red)
                    
                    NavigationLink(destination: ChatHistoryDateView() .environmentObject(manager)
                        .environment(\.managedObjectContext, manager.container.viewContext), label: {
                        SettingsItem(settingsItemType: .chatHistory)
                    })
                    .accentColor(.red)


                    
                }
                
            }
        }
        .background(.black)
        
        
    }
    
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}



