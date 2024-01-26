//
//  SettingsLitem.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/12/23.
//

import SwiftUI
import AVFoundation




struct SettingsItem: View {
    
    @State var settingsItemType:SettingsItemTypeIphone
    @AppStorage(VOLUMEUSERDEFAULT) private var volume = 0
    let viewModel = SettingsViewModel()
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @AppStorage(APIKEYVALUE) private var ApiKeyValue:String = ""
    @State private var showingMail = false
    @AppStorage(ENABLESPEECHSERDEFAULT) private var isSpeechEnabled = true

    
    var body: some View {
        
        
        if !isSpeechEnabled && settingsItemType == .volume{
            EmptyView()
            
        }else if settingsItemType == .enableSpeech && !isSpeechEnabled{
            
            HStack {
                getLeadingIcon()
                Spacer()
                getTrailingIcon()
            }
            .foregroundColor(.white)
            .frame(height: 70)
            .padding(.horizontal, 16)
            .background(Color.TEXTFIELDBGCOLOR)
            .cornerRadius(10)
            .padding(.horizontal, 16)
            
            
        }else if settingsItemType == .icon{
            HStack {
                getLeadingIcon()
                Spacer()
                getTrailingIcon()
            }
            
            .foregroundColor(.white)
            .frame(height: 70)
            .padding(.horizontal, 16)
            .background(Color.TEXTFIELDBGCOLOR)
            .cornerRadius(roundTopCorners(), corners: [.topLeft, .topRight])
            .cornerRadius(roundBottomCorners(), corners: [.bottomLeft, .bottomRight])
            .padding(.horizontal, 16)
            
            
        }else if settingsItemType == .about{
            HStack {
                getLeadingIcon()
                Spacer()
                getTrailingIcon()
            }
            
            .foregroundColor(.white)
            .frame(height: 70)
            .padding(.horizontal, 16)
            .background(Color.TEXTFIELDBGCOLOR)
            .cornerRadius(roundTopCorners(), corners: [.topLeft, .topRight])
            .cornerRadius(roundBottomCorners(), corners: [.bottomLeft, .bottomRight])
            .padding(.horizontal, 16)
            
            
            
        }else if settingsItemType == .apiKey{
            HStack {
                getLeadingIcon()
                Spacer()
                getTrailingIcon()
            }
            
            .foregroundColor(.white)
            .frame(height: 70)
            .padding(.horizontal, 16)
            .background(Color.TEXTFIELDBGCOLOR)
            .cornerRadius(roundTopCorners(), corners: [.topLeft, .topRight])
            .cornerRadius(roundBottomCorners(), corners: [.bottomLeft, .bottomRight])
            .padding(.horizontal, 16)
            
        }
        
        
        else{
            
            HStack {
                getLeadingIcon()
                Spacer()
                getTrailingIcon()
            }
            
            .foregroundColor(.white)
            .frame(height: 70)
            .padding(.horizontal, 16)
            .background(Color.TEXTFIELDBGCOLOR)
            .cornerRadius(roundTopCorners(), corners: [.topLeft, .topRight])
            .cornerRadius(roundBottomCorners(), corners: [.bottomLeft, .bottomRight])
            .padding(.horizontal, 16)
            .onTapGesture {
                if settingsItemType == .sendFeedBack{
                    self.showingMail.toggle()
                    
                }else if settingsItemType == .FAQ{
                    let url = URL(string: "https://www.google.com")
                    viewModel.openURL(url)
                    
                }else if settingsItemType == .leaveReview{
                    viewModel.rateApp()
                    
                }
                
                
            }
            
            .sheet(isPresented: $showingMail) {
                MailComposeViewController(toRecipients: ["dante@amazingelearning.com"], mailBody: "", subject: "Issue in $") {
                    // Did finish action
                }
            }
        }
        
        
        
       
        


        
       
    }
    
    func cornerRadius() -> CGFloat {
        switch settingsItemType {
        case .apiKey:
            return 10
        case .icon:
            return 10
        case .enableSpeech:
            return 0
        case .volume:
            return 0
        case .FAQ:
            return 0
        case .leaveReview:
            return 0
        case .sendFeedBack:
            return 0
        case .bugReport:
            return 0
        case .roadmap:
            return 0
        case .about:
            return 0
        }
    }
    
    func roundTopCorners() -> CGFloat{
        switch settingsItemType {
        case .apiKey:
            return 10
        case .icon:
            return 10
        case .enableSpeech:
            return 10
        case .volume:
            return 0
        case .FAQ:
            return 10
        case .leaveReview:
            return 10
        case .sendFeedBack:
            return 0
        case .bugReport:
            return 10
        case .roadmap:
            return 0
        case .about:
            return 10
        }
    }
    
    func roundBottomCorners() -> CGFloat{
        switch settingsItemType {
        case .apiKey:
            return 10
        case .icon:
            return 10
        case .enableSpeech:
            return 0
        case .volume:
            return 10
        case .FAQ:
            return 0
        case .leaveReview:
            return 0
        case .sendFeedBack:
            return 10
        case .bugReport:
            return 0
        case .roadmap:
            return 0
        case .about:
            return 10
        }
    }
    
    
    func getLeadingIcon()-> AnyView{
        switch settingsItemType {
        case .apiKey:
            return AnyView(
                HStack {
                    getSystemICon(name: "key.fill")
                    getTitle(title: "API  Key")
                }
            )
            
        case .icon:
            return AnyView(
                HStack{
                    Image("botIcon")
                        .resizable()
                        .frame(width: 40,height: 40)
                    
                    getTitle(title: "Icon")
                    
                }
            
            )

        case .enableSpeech:
            return AnyView(
                HStack {
                    getSystemICon(name: "ear.and.waveform")
                        .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    
                    getTitle(title: "Enable Speech")
                        .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                }
            )
            
            
        case .volume:
            return AnyView(
                HStack {
                    getSystemICon(name: "speaker.wave.3.fill")
                    getTitle(title: "Volume")
                    
                    
                    
                }
            )
            
            
        case .FAQ:
            return AnyView(
                HStack {
                    getSystemICon(name: "questionmark.circle.fill")
                    getTitle(title: "FAQ")
                    
                }
                    .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
            )
            
        case .leaveReview:
            return AnyView(
                HStack {
                    getSystemICon(name: "message.badge.circle.fill")
                    getTitle(title: "Leave a Review")
                    
                }
                    .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
            )
            
            
        case .sendFeedBack:
            return AnyView(
                HStack {
                    getSystemICon(name: "envelope.fill")
                    getTitle(title: "Send Feedback")
                    
                }
                    .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
            )
            
            
        case .bugReport:
            return AnyView(
                HStack {
                    getSystemICon(name: "ant.fill")
                    getTitle(title: "Bug Report")
                    
                }
                    .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
            )
            
            
        case .roadmap:
            return AnyView(
                HStack {
                    getSystemICon(name: "arrow.up.square")
                        .foregroundColor(.gray)
                    
                    getTitle(title: "Roadmap")
                    
                }
                
            )
            
            
            
        case .about:
            return AnyView(
                HStack {
                    getSystemICon(name: "info.circle.fill")
                        .foregroundColor(.gray)
                    
                    getTitle(title: "About Thready AI")
                    
                }
                
            )
            
            
        }
        
    }
    
    
    func getTrailingIcon()-> AnyView{
        switch settingsItemType {
        case .apiKey:
            
            if ApiKeyValue == ""{
                return AnyView( Text("") )
                
            }else{
                
                return AnyView(
                    HStack {
                        Text("ENABLED")
                            .font(.system(size: 12))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            .foregroundColor(.black)
                            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
                            .cornerRadius(5)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                )
                
            }
            
            
           
            
        case .icon:
            return AnyView(
                HStack {
                    Text("Petey")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            
            )

            
        case .enableSpeech:
            return AnyView(
                Toggle("", isOn: $isSpeechEnabled)
                    .toggleStyle(SwitchToggleStyle(tint: Color.getCurrentColor(PRIMARYCOLORVALUE)))
                    .onChange(of: isSpeechEnabled) { _ in
                        isSpeechEnabled.toggle()
                    }
            )
            
            
        case .volume:
            return AnyView(
                getVolumMenu()
            )
            
            
            
            
        case .FAQ:
            return AnyView(Text(""))
            
        case .leaveReview:
            return AnyView(Text(""))
            
            
        case .sendFeedBack:
            return AnyView(Text(""))
            
            
        case .bugReport:
            return AnyView(Text(""))
            
        case .roadmap:
            return AnyView(
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            )
            
            
        case .about:
            return AnyView(Text(""))
            
            
        }
        
    }
    
    
    func getSystemICon(name:String)-> some View{

        Image(systemName: name)
            .font(.system(size: 25))
            .fontWeight(.bold)

    }
    
    func getTitle(title:String)-> some View{
        
        Text(title)
            .font(.system(size: 20))
            .fontWeight(.bold)
        
    }
    
    
    func getEmptyItem()-> some View{
        return Text("")
    }
    
    
    func getVolumMenu() -> some View {
        var title = ""
        var audioPlayer: AVAudioPlayer?
        
        
        if volume == 0 {
            title = "Low"
        } else if volume == 1 {
            title = "Normal"
        } else if volume == 2 {
            title = "Loud"
        }
        
        return Menu {
            Button {
                volume = 0
                playWelcomeAudio(&audioPlayer)
            } label: {
                Label("Low", systemImage: volume == 0 ? "checkmark" : "")
            }
            
            Button {
                volume = 1
                playWelcomeAudio(&audioPlayer)
            } label: {
                Label("Normal", systemImage: volume == 1 ? "checkmark" : "")
            }
            
            Button {
                volume = 2
                playWelcomeAudio(&audioPlayer)
            } label: {
                Label("Loud", systemImage: volume == 2 ? "checkmark" : "")
            }
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                
                VStack {
                    Image(systemName: "chevron.up")
                    Image(systemName: "chevron.down")
                }.foregroundColor(.gray)
            }
        }
    }
    
    
    func playWelcomeAudio(_ audioPlayer: inout AVAudioPlayer?) {
        // Define the audio file URL
        guard let audioURL = Bundle.main.url(forResource: "welcome", withExtension: "mp3") else {
            print("Error: Failed to find audio file")
            return
        }
        
        switch volume {
        case 0:
            audioPlayer = try! AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.volume = 0.2 // adjust the volume as needed
        case 1:
            audioPlayer = try! AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.volume = 0.5 // adjust the volume as needed
        case 2:
            audioPlayer = try! AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.volume = 1.0 // adjust the volume as needed
        default:
            print("Error: Invalid volume level")
            return
        }
        
        audioPlayer?.play()
    }




    
    
}

struct SettingsItem_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItem(settingsItemType: .leaveReview)
    }
}
