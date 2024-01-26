//
//  VolumeSelection.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/25/23.
//

import SwiftUI
import AVFAudio

struct VolumeSelection: View {
    
    @AppStorage(VOLUMEUSERDEFAULT) private var volume = 0
   
    
    
    var body: some View {
        
        
        ScrollView{
            VStack {
                getIconItem(volume == 0, "Low", color: .BLUECOLOR)
                    .onTapGesture {
                        self.volume = 0
                        self.playWelcomeAudio()
                    }
                getIconItem(volume == 1, "Normal", color: .REDCOLOR)
                    .onTapGesture {
                        self.volume = 1
                        self.playWelcomeAudio()
                    }
                getIconItem(volume == 2, "Loud", color: .YELLOWCOLOR)
                    .onTapGesture {
                        self.volume = 2
                        self.playWelcomeAudio()
                    }
            }
            
        }
        
    }
    
    
    func playWelcomeAudio() {
        var audioPlayer: AVAudioPlayer?
        
        
        // Define the audio file URL
        guard let audioURL = Bundle.main.url(forResource: "welcome", withExtension: "mp3") else {
            print("Error: Failed to find audio file")
            return
        }

        // Create an AVAudioSession
        let session = AVAudioSession.sharedInstance()

        do {
            // Set the category to playback
            try session.setCategory(.playback, mode: .default)

            switch volume {
            case 0:
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.volume = 0.2 // adjust the volume as needed
            case 1:
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.volume = 0.5 // adjust the volume as needed
            case 2:
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.volume = 1.0 // adjust the volume as needed
            default:
                print("Error: Invalid volume level")
                return
            }

            // Play the audio
            audioPlayer?.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    
    
    
    func getIconItem(_ isSelected:Bool,_ title:String, color:Color)-> some View{
        
        HStack(alignment: .top){
            
            Text(title)
            
            
            Spacer()
            
            if isSelected{
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 10,height: 10)
                    .foregroundColor(.white)
            }
        }
        
        .padding(.horizontal,10)
        .frame(minHeight: 70)
        .background(Color.TEXTFIELDBGCOLOR)
        .cornerRadius(10)

     

    }
}

struct VolumeSelection_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSelection()
    }
}
