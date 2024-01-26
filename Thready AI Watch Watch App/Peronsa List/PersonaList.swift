//
//  PersonList.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 4/29/23.
//


import SwiftUI


struct PersonaList: View {
    
    //@State private var showDetailsList = false
    @State var selectedCatListIndex = 0
    @Binding var shouldDismissScreens: Bool
    var itemSelected:((_ selectedCatIndex:Int, _ selectedItemIndex:Int)-> Void)?
    @AppStorage(WATCHURCHASEDSTATUSMONTHLY) private var watchPurchasedStatusMonthly:Int = 0
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(0..<(watchPurchasedStatusMonthly == 0 ? 2 : HEADERTITLESWATCH.count/2), id: \.self) { index in
                        HStack(spacing:10) {
                            PersonItem(index: index*2)
                                .frame(width: geometry.size.width / 2 - 5, height: 100)
                                .background(Color.BOTTOMSHEETBGCOLOR)
                                .cornerRadius(5)
                                .onTapGesture {
                                    self.selectedCatListIndex = index*2
                                    shouldDismissScreens = true
                                }
                            
                            PersonItem(index: index*2+1)
                                .frame(width: geometry.size.width / 2 - 5, height: 100)
                                .background(Color.BOTTOMSHEETBGCOLOR)
                                .cornerRadius(5)
                                .onTapGesture {
                                    selectedCatListIndex = index*2+1
                                    shouldDismissScreens = true
                                    
                                }
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        
        
        .fullScreenCover(isPresented: $shouldDismissScreens) {
           
            PersonaDetailsList(selectedCatList: selectedCatListIndex, shouldDismissScreens: .constant(true)) { selectedItemIndex in
                //showDetailsList = false
                shouldDismissScreens = true
                itemSelected?(selectedCatListIndex, selectedItemIndex)
            }
        }
        
        
    }
    
    
}



struct PersonItem: View {
    let index:Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(HEADERTITLESICONS[index])
                .font(.system(size: 35))
            Text(HEADERTITLESWATCH[index])
                .font(.system(size: 12))
        }
    }
}







struct PersonaList_Previews: PreviewProvider {
    static var previews: some View {
        PersonaList(shouldDismissScreens: .constant(true))
    }
}
