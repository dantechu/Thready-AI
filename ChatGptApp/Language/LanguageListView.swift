//
//  CountryList.swift
//  Alpaca
//
//  Created by Administrator on 5/9/22.
//

import SwiftUI

struct LanguageListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var languages:LanguageModel = [LanguageModelElement(name: "English", shortCode: ""), LanguageModelElement(name: "Chinese", shortCode: ""), LanguageModelElement(name: "French", shortCode: ""), LanguageModelElement(name: "Italian", shortCode: ""), LanguageModelElement(name: "Russian", shortCode: "") ]
    @Binding var selectedLanguage:String
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName:"xmark")
                        .accentColor(.black)
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                        .frame(width: 30, height: 30)
                }
            }
            //Change
            List(languages) { item in
                Text(item.name)
                    .frame(width: UIScreen.screenWidth - 20, height: 20, alignment: .leading)
                    .padding([.leading], 35)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedLanguage = item.name
                        presentationMode.wrappedValue.dismiss()
                        
                    }
            }
            
        }
    }
    
}


struct LanguageModelElement: Codable,Identifiable,Hashable {
    let  name: String
    var id: String  { return UUID().uuidString}
    let  shortCode: String?

    enum CodingKeys: String, CodingKey {
        case  name
        case shortCode = "short_code"
    }
}
typealias LanguageModel = [LanguageModelElement]
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
