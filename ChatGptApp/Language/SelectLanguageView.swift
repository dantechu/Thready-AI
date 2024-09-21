//
//  ContentView.swift
//  newApp
//
//  Created by Administrator on 8/28/24.
//

import SwiftUI

struct SelectLanguageView: View {
    @State var language:LanguageModelElement = LanguageModelElement(name: "", shortCode: "")
    @State var showingSheet:Bool = false
    @State var isPresenting = false /// 1.

    var body: some View {
        NavigationView {
            
            VStack {
                Spacer()
                Text("Audio Language")
                    .font(.system(size: 20, weight: .bold, design: .default))
                
                HStack{
                    TextField("Enter text . . .", text: $language.name)
                        .padding(5)
                        .frame(height: 50)
                        .onTapGesture {
                            showingSheet = true
                        }
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .accentColor(.gray)
                        .padding(.trailing, 5)
                    
                } .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding([.leading, .trailing], 20)
                
                Spacer()
                
                Button(action: {
                    print("sign up bin tapped")
                    isPresenting = true
                }) {
                    Text("Next")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .background(Color.black) // If you have this
                .cornerRadius(25)
                .padding([.leading, .trailing], 40)
                
                NavigationLink(destination: RecordViewScreen(audioRecorder: AudioRecorder(), language: $language.shortCode), isActive: $isPresenting) { EmptyView() }

                
            }
            .sheet(isPresented: $showingSheet) {
                LanguageListView(selectedLanguage: $language)
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLanguageView()
    }
}
