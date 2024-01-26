//
//  PersonasList.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/27/23.
//

import SwiftUI

struct PersonasList: View {
    @State private var selectedCatIndex: Int = 0
    
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    
    var personaTapped:((_ selectedCat:Int, _ selectedItem:Int)->Void)?
    
    
    var body: some View {
        ZStack{
            Color.BOTTOMSHEETBGCOLOR.opacity(0.9)
                .ignoresSafeArea()
            
            
            VStack{
                
                tabView
                title
                headerList
                suggestionList
            }.padding(.top,20)
            
        }
        
       
        
    }
    
    
    
    var tabView: some View{
        
        HStack{
            Spacer()
            
            Rectangle()
                .frame(width: 80, height: 5)
                .cornerRadius(3)
                .foregroundColor(Color.gray)
                .padding(.bottom,10)
            
            Spacer()
            
        }
        
       
    }
    
    
    var title:some View{
        
        HStack {
            Text("Suggestion")
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Image(systemName: "lightbulb")
                .foregroundColor(.white)
        }
        .padding(.bottom,10)
        
    }
    
    
    var headerList:some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<HEADERTITLES.count) { index in
                    getHeaderItem(index)
                        .onTapGesture {
                            selectedCatIndex = index
                        }
                }
            }
        }
         
    }
    
    
    func getHeaderItem(_ index:Int)-> some View{
        
        Text(HEADERTITLES[index])
            .foregroundColor(.white)
            .font(.system(size: 18))
            .fontWeight(.bold)
            .padding(.horizontal,30)
            .padding(.vertical,20)
            .background(selectedCatIndex == index ? Color.getCurrentColor(PRIMARYCOLORVALUE) : Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
    
    var suggestionList: some View{
        
        ScrollView {
            LazyVStack {
                ForEach(0..<SUBTITLES[selectedCatIndex].count) { index in
                    getSuggestionItem(index)
                        .onTapGesture {
                            personaTapped?(selectedCatIndex, index)

                        }
                    
                }
            }
        }.padding(.top,30)
        
    }
    
    
    
    func getSuggestionItem(_ index:Int)-> some View{
        Text(SUBTITLES[selectedCatIndex][index])
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.vertical,10)
            .background(Color.gray.opacity(0.2))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal,20)
            .padding(.bottom,5)
    }
    
    
}

struct PersonasList_Previews: PreviewProvider {
    static var previews: some View {
        PersonasList()
    }
}
