//
//  AudioToTextViewModel.swift
//  newApp
//
//  Created by Administrator on 9/5/24.
//

import Foundation
import SwiftUI
import SwiftOpenAI
import Combine

class AudioToTextViewModel: ObservableObject {
    var translation: String = ""
    @Published var speechText = "" {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var isRecording : Bool = false
    @Published var isShowing: Bool = false
    let objectWillChange = PassthroughSubject<AudioToTextViewModel, Never>()

    var fileName:URL 
    private let service: OpenAIService
    var langaugae:String
    init(service: OpenAIService, filename:URL, langaugae:String ) {
        self.service  = service
        self.fileName = filename
        self.langaugae = langaugae
        
    }
        
    func fetchRecording() async throws{
        isShowing = true
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = self.fileName//path.appendingPathComponent(self.fileName)
        /// ['flac', 'm4a', 'mp3', 'mp4', 'mpeg', 'mpga', 'oga', 'ogg', 'wav', 'webm'] (supported formats)
        guard let data = try? Data(contentsOf:fileName) else {
            isShowing = false
            return }
                //let fileName = "narcos.m4a"
               // let data = Data(contentsOfURL:_) // Data retrieved from the file named "narcos.m4a".
                let parameters = AudioTranscriptionParameters(fileName: "myapp.m4a", file: data, language: "en") // **Important**: in the file name always provide the file extension.
                
        try await translate(parameters: parameters)
    }
    
    func translate(
       parameters: AudioTranscriptionParameters)
       async throws
    {
       do {
           let audioObject =  try await service.createTranscription(parameters: parameters)
           
          //translation = try await service.createTranslation(parameters: parameters).text
           DispatchQueue.main.async {[weak self] in
               self?.translation = audioObject.text

               self?.speechText = self?.translation ?? ""
               self?.isShowing = false
 
           }
       } catch {
           isShowing = false
          translation = "\(error)"
           print(error)
       }
    }
    
    func stopRecording() async throws{
        DispatchQueue.main.async {[weak self] in
            self?.isRecording = false
        }
        try await fetchRecording()
        
    }
    
    
}


