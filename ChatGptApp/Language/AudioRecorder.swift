//
//  AudioRecorder.swift
//  Voice Recorder
//
//  Created by Pinlun on 2019/10/30.
//  Copyright © 2019 Pinlun. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    override init() {
        super.init()
        fetchRecording()
    }
    @Published var timeRemaining:String = "00:00:00" {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var timerRemaining = 0 {
        didSet {
            objectWillChange.send(self)
        }
    }
    var fileName:URL = URL(fileURLWithPath: "")

    var audioRecorder: AVAudioRecorder!
    
    var recordings = [Recording]()
    @Published var timer = Timer()

    @Published var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
         fileName = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.record()
            startTimer()
            recording = true
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        fetchRecording()
        reset()
    }
    
    func cancelrecording() {
      audioRecorder.stop()
      deleteRecording(urlsToDelete: [fileName])
      fetchRecording()
    reset()
    }
    
    func pauseRecording() {
        recording = false
        audioRecorder.pause()
        stop()
    }
    
    func resumeRecording() {
        recording = true
        audioRecorder.record()
       startTimer()
    }
    func fetchRecording() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getFileDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        objectWillChange.send(self)
    }
    
    func deleteRecording(urlsToDelete: [URL]) {
            
        for url in urlsToDelete {
            print(url)
            do {
               try FileManager.default.removeItem(at: url)
            } catch {
                print("File could not be deleted!")
            }
        }
        
        fetchRecording()
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(notifyDelegate), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc
       func notifyDelegate() {
           var time = self.timerRemaining
           var hours = time / 3600
           time = time % 3600
           var mins = time / 60
           time = time % 60
           self.timeRemaining = "\(String(format: "%02d", hours)):\(String(format: "%02d", mins)):\(String(format: "%02d", time))"
           self.timerRemaining =  self.timerRemaining + 1
       }
    
    func stop() {
//        let fileName = "narcos.m4a"
//        let data = Data(contentsOfURL:_) // Data retrieved from the file named "narcos.m4a".
//        let parameters = AudioTranscriptionParameters(fileName: fileName, file: data) // **Important**: in the file name always provide the file extension.
//        let audioObject =  try await service.createTranscription(parameters: parameters)
        self.timer.invalidate()
    }
    
    func reset() {
        self.timerRemaining = 0
        timeRemaining = "00:00:00"
        self.timer.invalidate()
    }
}
