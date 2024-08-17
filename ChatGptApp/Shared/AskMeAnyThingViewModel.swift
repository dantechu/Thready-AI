//
//  ChatWidget.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/10/23.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation
import SwiftOpenAI

struct OpenAiKeys {
   static var aiproxyPartialKey = "v2|3818e635|S4ipxjdvEsscAnSY"
   static var aiproxyServiceURL = "https://api.aiproxy.pro/058d45fb/757e6601"
   
   static func getObject() -> OpenAIService{
       return OpenAIServiceFactory.service(aiproxyPartialKey: OpenAiKeys.aiproxyPartialKey, aiproxyServiceURL: OpenAiKeys.aiproxyServiceURL)
    }
}

class AskMeAnyThingViewModel: ObservableObject {
    
    @Published var isInteractingWithChatGPT = false
    @Published var messages: [MessageRow] = []
    @AppStorage(QUERYCOUNTER) var queryCounter: Int = 10
    @Published var inputMessage: String = ""
    @Published var isSpeaking: Bool = false
    private var synthesizer: AVSpeechSynthesizer?
    
    private let api: ChatGPTAPI
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var translation: String = ""
    @Published var speechText = ""
    @Published var isRecording : Bool = false
    
    private let service: OpenAIService
    init(api: ChatGPTAPI, enableSpeech: Bool = false, service: OpenAIService) {
        self.api = api
        self.service  = service
        if enableSpeech {
            synthesizer = .init()
        }
    }
    
    
    @MainActor
    func sendTapped() async {
        let text = inputMessage
        stopSpeaking()
        inputMessage = ""
        await send(text: text)
    }
    
    @MainActor
    func sendImageTapped() async {
        let text = inputMessage
        stopSpeaking()
        inputMessage = ""
        await sendImage(text: text)
    }
    
    @MainActor
    func clearMessages() {
        stopSpeaking()
        api.deleteHistoryList()
        withAnimation { [weak self] in
            self?.messages = []
        }
    }
    
    @MainActor
    func retry(message: MessageRow) async {
        guard let index = messages.firstIndex(where: { $0.id == message.id }) else {
            return
        }
        self.messages.remove(at: index)
        await send(text: message.sendText)
    }
    
    @MainActor
    private func send(text: String) async {
        isInteractingWithChatGPT = true
        var streamText = ""
        var messageRow = MessageRow(
            isInteractingWithChatGPT: true,
            sendImage: "profile",
            sendText: text,
            responseImage: Image(""), responseImageUrl: "",
            responseText: streamText,
            responseError: nil)
        
        self.messages.append(messageRow)
        
        do {
            Task {
                let data = try await api.sendMessageStream(text: text)
                switch data {
                case .success(let data):
                    var responseStr = data.choices.first?.message?.content
                    messageRow.responseText = responseStr?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.messages[self.messages.count - 1] = messageRow
                    queryCounter = queryCounter - 1
                case .failure(let error):
                    if error._code == -1200 {
                       // exit(1)
                    }
                    messageRow.responseError = error.localizedDescription
                }
                messageRow.isInteractingWithChatGPT = false
                self.messages[self.messages.count - 1] = messageRow
                isInteractingWithChatGPT = false
                speakLastResponse(responseText: self.messages.last?.responseText ?? "")
            }
        } catch {
            messageRow.responseError = error.localizedDescription
        }      
        
    }
    
    @MainActor
    private func sendImage(text: String) async {
        isInteractingWithChatGPT = true
        var streamText = ""
        var messageRow = MessageRow(
            isInteractingWithChatGPT: true,
            sendImage: "profile",
            sendText: text,
            responseImage: Image(""), responseImageUrl: "",
            responseText: streamText,
            responseError: nil)
        
        self.messages.append(messageRow)
        
        do {
            Task {
                let data = try await api.fetchImageForPrompt(text)
                switch data {
                case .success(let data):
                    let responseStr = data.data.first?.url
                    messageRow.responseImageUrl = responseStr ?? ""
                    self.messages[self.messages.count - 1] = messageRow
                    queryCounter = queryCounter - 1
                case .failure(let error):
                    if error._code == -1200 {
                        exit(1)
                    }
                    messageRow.responseError = error.localizedDescription
                }
                messageRow.isInteractingWithChatGPT = false
                self.messages[self.messages.count - 1] = messageRow
                isInteractingWithChatGPT = false
                speakLastResponse(responseText: self.messages.last?.responseText ?? "")
            }
        } catch {
            
            messageRow.responseError = error.localizedDescription
        }
        
    }

    func refreshKey(key:String) {
        api.refreshKey(key: key)
    }
    
    func speakLastResponse(responseText:String, synthesizer: AVSpeechSynthesizer? = nil) {
        self.synthesizer = synthesizer
        guard let synthesizer, !responseText.isEmpty else {
            return
        }
        
        
        stopSpeaking()
        let utterance = AVSpeechUtterance(string: responseText)
        utterance.voice = .init(language: "en-US")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.2
        synthesizer.speak(utterance )
        isSpeaking = true
    }
    
    func stopSpeaking() {
        synthesizer?.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    
    func isChatEmpty() -> Bool {
        messages.isEmpty
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
