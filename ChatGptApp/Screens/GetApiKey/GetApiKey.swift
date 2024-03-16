//
//  GetApiKey.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/9/23.
//

import SwiftUI

struct GetApiKey: View {
    
    @State var apiKeyInput: String = ""
    @ObservedObject var viewModel = GetApiKeyViewModel()
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @AppStorage(APIKEYVALUE) private var ApiKeyValue:String = ""
    
    
    
    var body: some View {
        
        ActivityIndicatorLoading(isShowing: $viewModel.isLoading) {
            CodeInputContent
        }
        .onAppear{
            apiKeyInput = ApiKeyValue
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        
        .navigationBarTitle("API Key")
        .navigationBarItems( trailing: getDeleteBtn )
        
        
        
        if !ApiKeyValue.isEmpty {
            
        }
        
    }
    
    var getDeleteBtn: some View{
        Button(action: {
            ApiKeyValue = ""
        }) {
            Text(ApiKeyValue.isEmpty ?"" : "Delete")
                .foregroundColor(.red)
        }
    }
    
    
    var CodeInputContent: some View{
        
        ZStack{
            
            Color.BGCOLOR
                .ignoresSafeArea()
            
            VStack(spacing:25){
                
                
                Text("Stay in control")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                
                Text("Go Premium and you will get all premium openai modes and features at your fingertips, purchase points to get credit to access the premium features. Credit never expires so no need to worry about weekly/monthly subscription.Get 100, 500 or 1000 points now!")
                
                    .padding(.horizontal,20)
                    .foregroundColor(.white)
                
                codeInputTextField
                
                getAPIKeyBtn
                
                testApiKey
                
                getSaveBtn
                
            }
            
            
        }
        .ignoresSafeArea()
        
        
    }
    
    
    
    var getAPIKeyBtn:some View{
        Button(action: {
            if let url = URL(string: "\(getApiKeyUrl)") {
                UIApplication.shared.open(url)
            }
        }) {
            Text("Get API Key")
                .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
        }.padding(.all,5)
    }
    
    
    
    var testApiKey: some View {
        Button {
            checkApiKey()
        } label: {
            HStack {
                Text("Test API key")
                    .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                
                if  viewModel.isValidAPIKey == 0 {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.red)
                    
                } else if viewModel.isValidAPIKey == 1 {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
        }
    }
    
    
    var getSaveBtn:some View{
        Button(action: {
            viewModel.saveApiKey(apiKeyInput)
        }) {
            Text("Save")
                .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
        }.padding(.all,5)
    }
    
    
    var codeInputTextField: some View {
        ZStack {
            Color.TEXTFIELDBGCOLOR
            SecureField("API key", text: $apiKeyInput, onCommit: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            })
            .frame(height: 50)
            .padding(.horizontal,10)
            .foregroundColor(.white)
            .accentColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .font(.system(size:18))
            .fontWeight(.bold)
            .colorScheme(.dark)
            .opacity(1)
            .onSubmit { checkApiKey() }
        }
        .frame(height: 50)
        .cornerRadius(10)
        .padding(.horizontal,20)
    }
    
    
    func checkApiKey(){
        if apiKeyInput.isEmpty { return }
        
        viewModel.isLoading = true
        Task { @MainActor in
            await viewModel.validateApiKey(apiKeyInput)
            viewModel.isLoading = false
        }
        
    }
    
    
    
}

struct GetApiKey_Previews: PreviewProvider {
    static var previews: some View {
        GetApiKey()
    }
}


