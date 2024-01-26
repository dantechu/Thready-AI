//
//  WatchColors.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/25/23.
//

import SwiftUI

struct WatchColors: View {
    
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    var body: some View {
        
        
        ScrollView{
            VStack {
                getIconItem(PRIMARYCOLORVALUE == 0, "Petey", color: .BLUECOLOR)
                    .onTapGesture {
                        self.PRIMARYCOLORVALUE = 0
                    }
                getIconItem(PRIMARYCOLORVALUE == 1, "Smiley", color: .REDCOLOR)
                    .onTapGesture {
                        self.PRIMARYCOLORVALUE = 1
                    }
                getIconItem(PRIMARYCOLORVALUE == 2, "Brains", color: .YELLOWCOLOR)
                    .onTapGesture {
                        self.PRIMARYCOLORVALUE = 2
                    }
                getIconItem(PRIMARYCOLORVALUE == 3, "Parkey", color: .GREENCOLOR)
                    .onTapGesture {
                        self.PRIMARYCOLORVALUE = 3
                    }
                getIconItem(PRIMARYCOLORVALUE == 4, "Simple", color: .PURPLECOLOR)
                    .onTapGesture {
                        self.PRIMARYCOLORVALUE = 4
                    }
                getIconItem(PRIMARYCOLORVALUE == 5, "Apollo", color: .MINTCOLOR)
                    .onTapGesture {
                        self.PRIMARYCOLORVALUE = 5
                    }
            }
            
        }
        
       
        
        
    }
    
    
    
    func getIconItem(_ isSelected:Bool,_ title:String, color:Color)-> some View{
        HStack(){
            HStack(alignment: .top){
                
                Circle()
                    .fill(color)
                    .frame(width: 25, height: 25)
                    .padding(.bottom,10)
                
                Text(title)
                    .padding(.top,2)
            }.frame(height: 25)
            
            
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
struct WatchColors_Previews: PreviewProvider {
    static var previews: some View {
        WatchColors()
    }
}
