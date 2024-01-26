//
//  PersonaDetailsList.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/29/23.
//

import SwiftUI


struct PersonaDetailsList: View {
    var selectedCatList:Int
    @Binding var shouldDismissScreens: Bool
    var itemTapped:((_ selectedItemIndex:Int)->Void)?
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(0..<PERSONALIST[selectedCatList].count, id: \.self) { index in
                        
                        getPersonaDetailsItem(index: index)
                            .frame(width: geometry.size.width, height: 50)
                            .background(Color.BOTTOMSHEETBGCOLOR)
                            .cornerRadius(5)
                            .onTapGesture {
                                shouldDismissScreens = true
                                itemTapped?(index)
                            }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        
    }
    
    
    
    func getPersonaDetailsItem( index:Int)-> some View{
        Text(SUBTITLES[selectedCatList][index])
            .font(.system(size: 15))
            .multilineTextAlignment(.center)
        
    }
    
}



struct PersonaDetailsList_Previews: PreviewProvider {
    static var previews: some View {
        PersonaDetailsList(selectedCatList: 0, shouldDismissScreens: .constant(true))
    }
}
