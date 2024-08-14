import AVFoundation
import SwiftUI
import SwiftOpenAI

@Observable
final class CreateAudioViewModel: NSObject {
    var avAudioPlayer = AVAudioPlayer()
    var isLoadingTextToSpeechAudio: TextToSpeechType = .noExecuted
    var transcription: String = ""
    var translation: String = ""
    var speechErrorMessage: String = ""
    var audioPlayer: AVAudioPlayer?
    
    private let service: OpenAIService
    
    init(service: OpenAIService) {
       self.service = service
    }
    
    enum TextToSpeechType {
        case noExecuted
        case isLoading
        case finishedLoading
        case finishedPlaying
    }
    
    func playAudioAgain() {
        avAudioPlayer.play()
    }
    
    @MainActor
    func createSpeech(input: String) async {
        isLoadingTextToSpeechAudio = .isLoading
        do {
            let data = try await service.createSpeech(parameters:  .init(model: .tts1, input: input, voice: .shimmer)).output
            isLoadingTextToSpeechAudio = .finishedLoading
            playAudio(from: data)
        } catch {
            isLoadingTextToSpeechAudio = .finishedLoading
            print(error)
            speechErrorMessage = "\(error)"
         }
    }
    
    private func playAudio(from data: Data) {
        do {
            // Initialize the audio player with the data
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            // Handle errors
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

extension CreateAudioViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isLoadingTextToSpeechAudio = .finishedPlaying
    }
}
