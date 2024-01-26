//
//  FullScreenLoading.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/19/23.
//

import SwiftUI

struct FullScreenLoading: View {
    
    
    var body: some View {
        
        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
            
            getGif()
            
        }
    }
    

    
    func getGif() -> some View {
        #if os(iOS)
        VStack {
            GifImageMobile("smiling")
                .frame(width: 200, height: 200)
                .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
            Text("Thinking...")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.medium)
        }
        #elseif os(watchOS)
        VStack {
            GifImageWatch()
                .frame(width: 100, height: 100)
                .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
            Text("Thinking...")
                .foregroundColor(.white)
                .font(.system(size: 15))
                .fontWeight(.medium)
        }
        #else
        VStack {
            Text("Unsupported platform")
        }
        #endif
    }

    
    
}

struct FullScreenLoading_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenLoading()
    }
}
