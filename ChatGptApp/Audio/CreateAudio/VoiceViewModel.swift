//
//  SpeechViewModel.swift
//  Thready AI
//
//  Created by Apple on 15/08/24.
//

import Foundation
import AVFoundation
import SwiftUI
import SwiftOpenAI
class VoiceViewModel : NSObject , ObservableObject , AVAudioPlayerDelegate {
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var translation: String = ""
    @Published var speechText = ""
    @Published var isRecording : Bool = false
    
    private let service: OpenAIService
    
    init(service: OpenAIService) {
       self.service = service
    }
    
   
 
    func startRecording(){
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Can not setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("CO-Voice.m4a")
        
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    func fetchRecording() async throws{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("CO-Voice.m4a")
        /// ['flac', 'm4a', 'mp3', 'mp4', 'mpeg', 'mpga', 'oga', 'ogg', 'wav', 'webm'] (supported formats)
        guard let data = try? Data(contentsOf:fileName) else { return }
        try await translate(parameters: .init(fileName: "myapp.m4a", file: data))
    }
    
    func translate(
       parameters: AudioTranslationParameters)
       async throws
    {
       do {
          translation = try await service.createTranslation(parameters: parameters).text
           print("translation text:",translation)
           speechText = translation
       } catch {
          translation = "\(error)"
       }
    }
    
    func stopRecording() async throws{
        audioRecorder.stop()
        isRecording = false
        try await fetchRecording()
    }
    
}
