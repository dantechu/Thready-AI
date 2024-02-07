//
//  ChatHeader.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/10/23.
//

import SwiftUI

struct ChatHeader: View {
    var messagesCount:Int
    
    let shareTapped:(()->Void)?
    let finishTapped:(()->Void)?
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    var body: some View {
     
        if messagesCount == 0{
            getEmptyView()
        }else{
            getHeader()
        }

       
    }
    
    
    func getEmptyView() -> some View{
        Text("")
    }
    
    func getHeader()-> some View{
        
        HStack {
            Button(action: {
                shareTapped?()
            }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 22))
                    .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
            }
            
            
            Spacer()
            
            Button(action: {
                finishTapped?()
            }) {
                Text("Save")
                    .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 22))
                    .fontWeight(.bold)
            }
        }.padding()
        
    }
    
    
}

struct ChatHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeader(messagesCount: 1) {
            
        } finishTapped: {
            
        }

    }
}
