//
//  SettingsWatcg.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/18/23.
//

import SwiftUI

struct SettingsWatch: View {
    
    @State private var isPresentingIcons = false
    @State private var isPresentingThemes = false
    @State private var isPresentingAbout = false
    @State private var isPresentingPurchasingScreen = false
    
    
    @AppStorage(ENABLESPEECHSERDEFAULT) private var isSpeechEnabled = true
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    
    
    var body: some View {
        
        NavigationView {
            scrollList
        }
        
    }
    
    
    
    var scrollList: some View{
        ScrollView {
            LazyVStack(spacing: 0) {
                
                
                SettingsItemWatch(settingsItemTypeWatch: .unLockChatGPT)
                    .onTapGesture {
                        isPresentingPurchasingScreen = true
                    }
                    .fullScreenCover(isPresented: $isPresentingPurchasingScreen) {
                        ProVersion {
                            isPresentingPurchasingScreen = false
                        }
                    }
                
                
                
                SettingsItemWatch(settingsItemTypeWatch: .APIKey)
                
                
//                SettingsItemWatch(settingsItemTypeWatch: .icon)
//                    .onTapGesture {
//                        isPresentingIcons = true
//                    }
//                    .fullScreenCover(isPresented: $isPresentingIcons) {
//                        Icons()
//                    }
                
                
//                SettingsItemWatch(settingsItemTypeWatch: .theme)
//                    .onTapGesture {
//                        isPresentingThemes = true
//                    }
//                    .fullScreenCover(isPresented: $isPresentingThemes) {
//                        WatchColors()
//                    }
                
                
                
                SettingsItemWatch(settingsItemTypeWatch: .enableSpeech)
                
                if isSpeechEnabled{
                    SettingsItemWatch(settingsItemTypeWatch: .volume)
                        .onTapGesture {
                            isPresentingThemes = true
                        }
                        .fullScreenCover(isPresented: $isPresentingThemes) {
                            VolumeSelection()
                        }
                }
                
                SettingsItemWatch(settingsItemTypeWatch: .about)
                    .onTapGesture {
                        isPresentingAbout = true
                    }
                    .fullScreenCover(isPresented: $isPresentingAbout) {
                        About()
                    }
                
                
            }
        }
        .background(.black)


    }
}

struct SettingsWatch_Previews: PreviewProvider {
    static var previews: some View {
        SettingsWatch()
    }
}
