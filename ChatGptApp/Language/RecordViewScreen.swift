//
//  ContentView.swift
//  Voice Recorder
//
//  Created by Pinlun on 2019/10/30.
//  Copyright © 2019 Pinlun. All rights reserved.
//

import SwiftUI

struct RecordViewScreen: View {
    //let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) var dismiss
    @StateObject var audioRecorder: AudioRecorder
    @State var fileurl :URL = URL(fileURLWithPath: "")
    @State var isPresenting :Bool = false
    @Binding var language:String
    @State var showAlert = false
    init(audioRecorder: AudioRecorder, language: Binding<String>) {
        _audioRecorder = StateObject(wrappedValue: audioRecorder)
        _language = language
        audioRecorder.stop()
        audioRecorder.startRecording()
    }
    var body: some View {
        VStack {
            RecordingsList(fileurl: $fileurl, isPresenting: $isPresenting, audioRecorder: audioRecorder)
            NavigationLink(destination: AudioToTextView(audioViewModel: AudioToTextViewModel(filename: fileurl, langaugae: language)), isActive: $isPresenting) { EmptyView() }
            VStack {
                
                Text("Recording")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .padding([.bottom], 20)
                
                Text("\(audioRecorder.timeRemaining)")
                    .font(.system(size: 30, weight: .bold, design: .default))
                
                HStack {
                    Button(action: {
                        
                        audioRecorder.timerRemaining = 0
                        self.audioRecorder.cancelrecording()
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                            .foregroundColor(.black)
                            .padding(.bottom, 40)
                            .padding(.trailing, 20)

                    }
                    
                    Button(action: {
                        if audioRecorder.recording == true {
                            self.audioRecorder.stopRecording()
                            fileurl = self.audioRecorder.fileName
                            isPresenting = true
                        }else {
                            showAlert = true
                        }
                    }) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.black)
                            .padding(.bottom, 40)
                            .padding([.trailing, .leading], 20)

                    }

                    if audioRecorder.recording == true {
                        Button(action: {
                            self.audioRecorder.pauseRecording()
                        }) {
                            Image(systemName: "pause.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipped()
                                .foregroundColor(.black)
                                .padding(.bottom, 40)
                                .padding([.leading], 20)
                            
                        }
                    }else {
                        Button(action: {
                            self.audioRecorder.resumeRecording()
                        }) {
                            Image(systemName: "play.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipped()
                                .foregroundColor(.black)
                                .padding(.bottom, 40)
                                .padding([.leading], 20)
                            
                        }
                    }
                }
                
               

            }.onAppear(perform: {
               
            })
        }
        .alert("please first record the audio", isPresented: $showAlert) {
                   Button("OK", role: .cancel) {
                       showAlert = false
                   }
        }
        .navigationBarTitle("Voice Recorder")
        .navigationBarItems(trailing: EditButton())
        
    }
    
    
}


