//
//  ActivityIndicatorLoadingView.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 5/3/23.
//

import Foundation
import SwiftUI

struct ActivityIndicatorLoadingView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            
            if isShowing {
                Color.black.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding(10)
                    .background(Color.black.opacity(0.8))
                    .shadow(radius: 10)
            }
        }
    }
}


struct ActivityIndicatorLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorLoadingView(isShowing: .constant(true))
    }
}



