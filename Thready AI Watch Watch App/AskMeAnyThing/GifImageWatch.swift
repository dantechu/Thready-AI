//
//  GIFView.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/20/23.
//


import SwiftUI

struct GifImageWatch: View {
    let imageNamePrefix = "smiling-"
    let frameCount = 45
    let frameDuration = 0.1
    
    @State private var currentFrameIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(imageNamePrefix + "\(currentFrameIndex)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onAppear {
                // Start the animation loop when the view appears
                
                Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
                    currentFrameIndex = (currentFrameIndex + 1) % frameCount
                }
            }
        }
    }
}



struct GifImageWatch_Previews: PreviewProvider {
    static var previews: some View {
        GifImageWatch()
    }
}
