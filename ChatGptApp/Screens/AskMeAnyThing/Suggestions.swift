//
//  Suggestiobs.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/27/23.
//

import SwiftUI

struct Suggestions: View {
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    var suggestionTapped:(()->Void)?
    
    
    var body: some View {
        VStack{
            
            Text("Hi! You can send your message or get inspired from suggestions.")
                .foregroundColor(.white)
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    suggestionTapped?()
                }) {
                    HStack {
                        Image(systemName: "lightbulb")
                            .foregroundColor(.white)
                        Text("Suggestion")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.BGCOLOR)
                    .cornerRadius(10)
                }
                
                
            }
            
        }
        .padding()
        .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
        .cornerRadius(10)
        .padding(.horizontal,20)
        
        
        
        
    }
}

struct Suggestions_Previews: PreviewProvider {
    static var previews: some View {
        Suggestions()
    }
}
