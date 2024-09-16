//
//  AudioToTextView.swift
//  newApp
//
//  Created by Administrator on 9/5/24.
//

import Foundation
import SwiftUI

struct AudioToTextView: View {
    
    @StateObject var audioViewModel: AudioToTextViewModel
    var body: some View {
        LoadingView(isShowing: $audioViewModel.isShowing) {
            VStack{
                Text(audioViewModel.speechText)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding([.leading, .trailing], 20)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.onAppear {
                    Task{
                    do {
                        try? await audioViewModel.fetchRecording()
                    }catch {
                        print(error)
                    }
                }

            
        }
    }
}



struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

//struct ActivityIndicator: UIViewRepresentable {
//
//    @Binding var isAnimating: Bool
//    let style: UIActivityIndicatorView.Style
//
//    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
//        return UIActivityIndicatorView(style: style)
//    }
//
//    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
//        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
//    }
//}
