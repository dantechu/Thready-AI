//
//  SettingsItemWatch.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/18/23.
//

import SwiftUI

struct SettingsItemWatch: View {
    
    @State var settingsItemTypeWatch:SettingsItemTypeWatch
    @State private var isOn = true
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @AppStorage(ENABLESPEECHSERDEFAULT) private var isSpeechEnabled = true
    @AppStorage(VOLUMEUSERDEFAULT) private var volume = 0
    @AppStorage(WATCHURCHASEDSTATUSMONTHLY) private var watchPurchasedStatusMonthly:Int = 0
    
    
    var body: some View {
        HStack {
            getLeadingIcon()
            Spacer()
            
        }
        .foregroundColor(.white)
        .frame(height: getHeight())
        .padding(.horizontal, 16)
        .background(Color.TEXTFIELDBGCOLOR)
        .cornerRadius(10)
        .padding(.bottom,5)
    }
    
    
    
    func getHeight()-> CGFloat{
        switch settingsItemTypeWatch {
        case .unLockChatGPT:
            return watchPurchasedStatusMonthly == 0 ? 80.0 : 0
        case .APIKey:
            return 100.0
        case .icon:
            return 60.0
        case .theme:
            return 60.0
        case .enableSpeech:
            return 100.0
        case .volume:
            return 100.0
        case .about:
            return 60.0
        }
    }
   
    func getLeadingIcon()-> AnyView{
        switch settingsItemTypeWatch {
        case .unLockChatGPT:
            if watchPurchasedStatusMonthly == 1{
                return AnyView(Text(""))
            }else{
                
                return AnyView(
                    VStack (alignment: .leading, spacing: 8) {
                        getSystemICon(name: "lock.open.trianglebadge.exclamationmark")
                        getTitle(title: "Unlock Pro version")
                    }
                )
                
            }
            
            
            
        case .APIKey:
            return AnyView(
                VStack(alignment: .leading, spacing: 8){
                    getSystemICon(name: "key")
                    getTitle(title: "Api Key")
                    getApiKeyStatus()
                }
            )
            
        case .icon:
            return AnyView(
                VStack(alignment: .leading, spacing: 8) {
                    getTitle(title: "Icon")
                    HStack(spacing: 5){
                        getSystemICon(name: "circle.circle.fill")
                        getTitle(title: "Petey",font: 9)
                    }
                    .foregroundColor(.gray)
                    
                }
            )
            
        case .theme:
            return AnyView(
                VStack(alignment: .leading, spacing: 8) {
                    getTitle(title: "Theme")
                    HStack(spacing: 5){
                        getColoredView()
                        getTitle(title: "Blue",font: 9)
                    }
                    .foregroundColor(.gray)
                    
                }
            )
            
        case .enableSpeech:
            return AnyView(
                VStack(alignment: .leading, spacing: 8) {
                    getSystemICon(name: "ear.and.waveform")
                    HStack(spacing: 5){
                        getTitle(title: "Enable\nSpeech")
                        
                        Spacer()
                        
                        Toggle("", isOn: $isSpeechEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: Color.getCurrentColor(PRIMARYCOLORVALUE)))
                            .scaleEffect(0.70)
                            .onChange(of: isSpeechEnabled) { _ in
                                isSpeechEnabled.toggle()
                            }
                    }
                    
                }
            )
            
        case .volume:
            return AnyView(
                VStack(alignment: .leading, spacing: 8) {
                    getSystemICon(name: "speaker.wave.3.fill")
                    getTitle(title: "Volume")
                    switch volume {
                    case 0:
                        getTitle(title: "Low", font: 9)
                    case 1:
                        getTitle(title: "Normal", font: 9)
                    case 2:
                        getTitle(title: "Loud", font: 9)
                    default:
                        getTitle(title: "Unknown", font: 9)
                    }
                }
            )

            
        case .about:
            return AnyView(
                VStack(alignment: .leading, spacing: 8) {
                    getSystemICon(name: "info.circle.fill")
                        .foregroundColor(.gray)
                    getTitle(title: "About Petey")
                }
            )
            
        }
        
        
        
    }
  
    
    func getSystemICon(name:String)-> some View{

        Image(systemName: name)
            .font(.system(size: 18))

    }
    
    func getTitle(title:String, font:CGFloat = 15)-> some View{
        
        Text(title)
            .font(.system(size: font))
            .fontWeight(.regular)
        
    }
    
    func getApiKeyStatus() -> some View {
        return Text("ENABLED")
            .foregroundColor(.black)
            .font(.system(size: 10))
            .fontWeight(.medium)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .cornerRadius(4)
    }

    
    func getColoredView()-> some View{
        return Circle()
            .frame(width: 18)
            .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
    }
    
    
    
    
}


struct SettingsItemWatch_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItemWatch(settingsItemTypeWatch: .unLockChatGPT)
    }
}


