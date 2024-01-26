//
//  About.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/23/23.
//

import SwiftUI

struct About: View {
    
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    let isWatchOS = currentPlatform == .watchOS
    
    
    var body: some View {
        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
            
            
            VStack{
                
#if os(iOS)
                    DetailListMobile
                        .padding(.top,40)
                    
                    Spacer()
                    
#elseif os(watchOS)
                    DetailListWatchOS

#endif
                    
                    
                }
                
                
            }
    
       
    }
    
    
    
    var DetailListMobile: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Welcome to Thready!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
                Spacer()
            }
            Text("This is an app that lets you talk to a smart computer named Thready using your Apple Watch or iPhone. It's helpful when you want to learn something quickly or write a long message without typing. Just remember to have fun and be nice!")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top)
                .padding(.bottom,30)
            
            
            Link(destination: URL(string: "https://apps.apple.com/us/developer/dante-chu/id1663119067")!) {
                Text("Other apps by Thready")
                    .fontWeight(.semibold)
                    .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
                    .padding(.leading,0)
            }
            
            
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)
                .padding(.vertical)

            VStack(alignment: .leading, spacing:20) {
                Text("Powered by Amazing eLearning")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)


                Link(destination: URL(string: "https://www.amazingelearning.com")!) {
                    Text("Made by Amazingelearning.com")
                        .fontWeight(.semibold)
                        .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
                        .padding(.leading,0)
                }

            }
            
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)
                .padding(.vertical)
            
            
            Text("Thready 2.4")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        
        
    }
    
    
    var DetailListWatchOS: some View {
        
        ScrollView{
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Welcome\n to Thready!")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
                    Spacer()
                }
                
                Text("This is an app that lets you talk to a smart computer named Thready using your Apple Watch or iPhone. It's helpful when you want to learn something quickly or write a long message without typing. Just remember to have fun and be nice!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)
                    .padding(.bottom,30)


                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 1)
                    .padding(.vertical)




                VStack(alignment: .leading, spacing:20) {
                    Text("Powered by Amazing eLearning")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)


                    Text("Made by Amazingelearning.com")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }


                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 1)
                    .padding(.vertical)


                Text("Thready 2.4")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                
            }
            
            .padding(.horizontal,5)
            
            
        }
        
     
    }
    
    
}


struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
