//
//  ActivityIndicatorLoading.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/9/23.
//

import SwiftUI


struct ActivityIndicatorLoading<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.getCurrentColor(PRIMARYCOLORVALUE)))
                    .scaleEffect(2.0)
                    .frame(width: geometry.size.width / 2,
                           height: geometry.size.height / 5)
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
    
}





struct ActivityIndicatorLoading_Previews: PreviewProvider {
    static var previews: some View {
        
        ActivityIndicatorLoading(isShowing: .constant(true)) {
            Text("hello")
        }
        
    }
}






struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}




