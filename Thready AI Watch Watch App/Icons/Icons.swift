//
//  Icons.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/25/23.
//

import SwiftUI

struct Icons: View {
    
    @State private var selectedIndex = 0
    
    var body: some View {
        
        
        ScrollView{
            VStack {
                getIconItem(selectedIndex == 0, "Petey")
                    .onTapGesture {
                        self.selectedIndex = 0
                    }
                getIconItem(selectedIndex == 1, "Smiley")
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                getIconItem(selectedIndex == 2, "Brains")
                    .onTapGesture {
                        self.selectedIndex = 2
                    }
                getIconItem(selectedIndex == 3, "Parkey")
                    .onTapGesture {
                        self.selectedIndex = 3
                    }
                getIconItem(selectedIndex == 4, "Simple")
                    .onTapGesture {
                        self.selectedIndex = 4
                    }
                getIconItem(selectedIndex == 5, "Apollo")
                    .onTapGesture {
                        self.selectedIndex = 5
                    }
            }
            
        }
        
       
        
        
    }
    
    
    
    func getIconItem(_ isSelected:Bool,_ title:String)-> some View{
        HStack{
            HStack{
                Image("botIcon")
                    .resizable()
                    .frame(width: 30,height: 30)
                Text(title)
            }
            Spacer()
            if isSelected{
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 10,height: 10)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal,10)
        .frame(minHeight: 70)
        .background(Color.TEXTFIELDBGCOLOR)
        .cornerRadius(10)
        

    }
}


struct Icons_Previews: PreviewProvider {
    static var previews: some View {
        Icons()
    }
}
