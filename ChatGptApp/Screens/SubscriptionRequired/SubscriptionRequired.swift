//
//  SubscriptionRequired.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 5/1/23.
//

import SwiftUI

struct SubscriptionRequired: View {
    
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @State private var isPresentingSettings = false
    @State private var isPresentingAddApiKey = false
    @State private var isPresentingMonthlySubs = false
    
    
    var body: some View {
        
        ZStack{
            
            Color.BGCOLOR
                .ignoresSafeArea()
            
            VStack(spacing:25){
                
                Spacer()
                headerText
                    .padding(.horizontal,20)
                Spacer()
               
                
                unLockBtns

            }
            
            
        }
        .fullScreenCover(isPresented: $isPresentingSettings) {
            Settings()
        }
        .sheet(isPresented: $isPresentingAddApiKey) {
            GetApiKey()
                .presentationDetents([.fraction(0.99)])
            
        }
        
        .fullScreenCover(isPresented: $isPresentingMonthlySubs) {
            MonthlySubscription {
                isPresentingMonthlySubs = false
            }
            
        }
        
    }
    
    
    var headerText: some View{
        VStack(spacing: 50){
            
            GifImageMobile("smiling")
                .frame(width: 200, height: 200)
                .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
                .onTapGesture {
                    settingTapped()
                }
            
            
            Text("Subscription Required")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            
            Text("Go Premium and you will get all premium openai modes and features at your fingertips, purchase points to get credit to access the premium features. Credit never expires so no need to worry about weekly/monthly subscription.Get 100, 500 or 1000 points now!")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.system(size: 15))
            
        }
        
    }
    
    
    var unLockBtns:some View{
        
        VStack(spacing: 20){
            Button(action: {
                unlockMikeyTapped()
            }) {
                Text("Unlock Thready for iOS")
                    .frame(height: 60)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
            }
            .frame(maxWidth: .infinity)
            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .cornerRadius(10)
            
            
            Button(action: {
                addApiKeyTapped()
            }) {
                Text("Add API Key")
                    .frame(height: 60)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
            }
            .frame(maxWidth: .infinity)
            .background(Color.APPERANCEUNSELECTEDBGCOLOR)
            .cornerRadius(10)
            

        }
        .padding(.bottom,0)
        .padding(.horizontal,20)
        
        
        
    }
    
    
    
    
    func settingTapped(){
        isPresentingSettings = true
        
    }
    
    func unlockMikeyTapped(){
        isPresentingMonthlySubs = true
        
    }
    
    func addApiKeyTapped(){
        isPresentingAddApiKey = true
    }
    
    
    
}

struct SubscriptionRequired_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionRequired()
    }
}
