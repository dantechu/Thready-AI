//
//  EmojiSelectection.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/24/23.
//

import SwiftUI

struct EmojiSelectection: View {
    
    
    @State private var selectedIcon: Int? = 0
    

    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    
    
    var body: some View {
        
        
        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
            
            
            VStack{
                getIconsList()
                
                getThemeList()
            }
 
        }
        
        
        
       
        
        

    }
    
    
    func getIconsList()-> some View{
        
        VStack(alignment:.leading){
            Text("Icon")
                .padding(.leading,20)
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            
            GeometryReader { geometry in
                VStack( spacing: 0) {
                    HStack(spacing: 0) {
                        getItem(text: "Petey", icon: "lasso", selectedItem: selectedIcon == 0)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                selectedIcon = 0
                            }
                        
                        
                        getItem(text: "Smiley", icon: "lasso", selectedItem: selectedIcon == 1)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                selectedIcon = 1
                            }
                        
                        
                        getItem(text: "Vrains", icon: "lasso", selectedItem: selectedIcon == 2)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                selectedIcon = 2
                            }
                    }
                    .padding(.bottom, 10)
                    
                    
                    
                    HStack(spacing: 0) {
                        getItem(text: "Petey", icon: "lasso", selectedItem: selectedIcon == 3)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                selectedIcon = 3
                            }
                        
                        getItem(text: "Smiley", icon: "lasso", selectedItem: selectedIcon == 4)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                selectedIcon = 4
                            }
                        
                        getItem(text: "Vrains", icon: "lasso", selectedItem: selectedIcon == 5)
                            .frame(width: geometry.size.width / 3 - 13, height: 120)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                selectedIcon = 5
                            }
                    }
                }
            }
            
            
        }
        
    }

    
    func getThemeList()-> some View{
        
        VStack(alignment:.leading){
            Text("Theme")
                .padding(.leading,20)
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            
            GeometryReader { geometry in
                VStack( spacing: 0) {
                    HStack(spacing: 0) {
                        getItem(text: "Petey", icon: "lasso", selectedItem: PRIMARYCOLORVALUE == 0, color: .BLUECOLOR)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                PRIMARYCOLORVALUE = 0
                                
                            }
                        
                        
                        getItem(text: "Smiley", icon: "lasso", selectedItem: PRIMARYCOLORVALUE == 1, color: .REDCOLOR)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                PRIMARYCOLORVALUE = 1
                            }
                        
                        
                        getItem(text: "Vrains", icon: "lasso", selectedItem: PRIMARYCOLORVALUE == 2, color: .YELLOWCOLOR)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                PRIMARYCOLORVALUE = 2
                            }
                    }
                    .padding(.bottom, 10)
                    
                    
                    
                    HStack(spacing: 0) {
                        getItem(text: "Petey", icon: "lasso", selectedItem: PRIMARYCOLORVALUE == 3, color: .GREENCOLOR)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                PRIMARYCOLORVALUE = 3
                            }
                        
                        getItem(text: "Smiley", icon: "lasso", selectedItem: PRIMARYCOLORVALUE == 4, color: .PURPLECOLOR)
                            .frame(width: geometry.size.width / 3 - 13, height: 140)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                PRIMARYCOLORVALUE = 4
                            }
                        
                        getItem(text: "Vrains", icon: "lasso", selectedItem: PRIMARYCOLORVALUE == 5, color: .MINTCOLOR)
                            .frame(width: geometry.size.width / 3 - 13, height: 120)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                PRIMARYCOLORVALUE = 5
                            }
                    }
                }
            }
            
            
        }
        
        
    }
   
    
    
    
    func getItem(text:String, icon:String, selectedItem:Bool, color:Color? = nil) -> some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .fill(selectedItem ? Color.clear : Color.APPERANCEUNSELECTEDBGCOLOR)
                .frame(height: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedItem ? .getCurrentColor(PRIMARYCOLORVALUE) : Color.clear, lineWidth: 3)
                )
            
            
            
            VStack(spacing: 0){
                
                
                if let color = color{
                    
                    Circle()
                        .fill(color)
                        .frame(width: 35, height: 35)
                        .padding(.bottom,10)
                    
                    
                    
                }else{
                    
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(selectedItem ? .getCurrentColor(PRIMARYCOLORVALUE) : .white)
                        .frame(width: 30, height: 30)
                        .padding()
                    
                }
                
               
                
                Text(text)
                    .foregroundColor(selectedItem ? .getCurrentColor(PRIMARYCOLORVALUE) : .white)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
            }
            
            
            
            if selectedItem {
                ZStack {
                    Circle()
                        .fill(Color.getCurrentColor(PRIMARYCOLORVALUE))
                        .frame(width: 30, height: 30)
                    Text("✓")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold))
                }
                .offset(x: -55 , y: 55)
            }
            
            
        }.frame(height: 150)
        
        
        
    }
}



struct EmojiSelectection_Previews: PreviewProvider {
    static var previews: some View {
        EmojiSelectection()
    }
}
