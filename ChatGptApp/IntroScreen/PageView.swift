//
//  PageView.swift
//  SlidingIntroScreen
//
//  Created by Federico on 18/03/2022.
//

import SwiftUI

struct PageView: View {
    var page: Page
    
    var body: some View {
        VStack(spacing: 15) {
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .cornerRadius(20)
                .background(.gray.opacity(0.10))
                .cornerRadius(10)
            
            Text(page.name)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .padding(20)
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .frame(width: 300)
        }.padding(.top, 20)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage)
    }
}
