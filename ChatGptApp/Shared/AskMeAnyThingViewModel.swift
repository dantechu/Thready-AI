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


class AskMeAnyThingViewModel: ObservableObject {
    
    @Published var isInteractingWithChatGPT = false
    @Published var messages: [MessageRow] = []
    @Published var inputMessage: String = ""
    @Published var isSpeaking: Bool = false
    private var synthesizer: AVSpeechSynthesizer?
    
    private let api: ChatGPTAPI
    
    init(api: ChatGPTAPI, enableSpeech: Bool = false) {
        self.api = api
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
            responseImage: Image(""),
            responseText: streamText,
            responseError: nil)
        
        self.messages.append(messageRow)
        
        do {
            let stream = try await api.sendMessageStream(text: text)
            for try await text in stream {
                streamText += text
                messageRow.responseText = streamText.trimmingCharacters(in: .whitespacesAndNewlines)
                self.messages[self.messages.count - 1] = messageRow
            }
        } catch {
            messageRow.responseError = error.localizedDescription
        }
        
        messageRow.isInteractingWithChatGPT = false
        self.messages[self.messages.count - 1] = messageRow
        isInteractingWithChatGPT = false
        speakLastResponse(responseText: self.messages.last?.responseText ?? "")
        
    }
    
    @MainActor
    private func sendImage(text: String) async {
        isInteractingWithChatGPT = true
        var streamText = ""
        var messageRow = MessageRow(
            isInteractingWithChatGPT: true,
            sendImage: "profile",
            sendText: text,
            responseImage: Image(""),
            responseText: streamText,
            responseError: nil)
        
        self.messages.append(messageRow)
        
        do {
            let stream = try await api.fetchImageForPrompt(text)
            messageRow.responseImage = Image(uiImage: stream)
            self.messages[self.messages.count - 1] = messageRow
        } catch {
            messageRow.responseError = error.localizedDescription
        }
        messageRow.isInteractingWithChatGPT = false
        self.messages[self.messages.count - 1] = messageRow
        isInteractingWithChatGPT = false
        speakLastResponse(responseText: self.messages.last?.responseText ?? "")
        
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

    
    
}
