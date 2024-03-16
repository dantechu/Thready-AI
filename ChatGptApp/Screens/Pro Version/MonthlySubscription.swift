//
//  MonthlySubscription.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 5/2/23.
//

import SwiftUI
enum AlertType {
    case success
    case error
    case restoredSuccess
}


struct MonthlySubscription: View {
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @AppStorage(PURCHASEDSTATUSMONTHLY) private var purchasedStatusMonthly:Int = 0
    
    @State var isLoading = false
    @State var showAlert: Bool = false
    @State private var currentAlert: AlertType = .success
    @State var failureError = ""
    @State var price = "loading..."

    let subscriptionManager = SubscriptionManager(productIDs: [monthlyAIPId])

    var crossTapped:(()->Void)?
    
    var body: some View {

        ActivityIndicatorLoading(isShowing: $isLoading) {
            fullScreenData
                .alert(isPresented: $showAlert) {
                    switch currentAlert {
                    case .success:
                        return Alert(
                            title: Text("Success"),
                            message: Text("Pro version purchased successfully"),
                            dismissButton: .default(
                                Text("OK"),
                                action: {
                                    showAlert = false
                                    //purchasedStatusMonthly = 1
                                }
                            )
                        )
                        
                    case .error:
                        return Alert(
                            title: Text("Error"),
                            message: Text(failureError),
                            dismissButton: .default(
                                Text("OK"),
                                action: {
                                    showAlert = false
                                }
                            )
                        )
                        
                    case .restoredSuccess:
                        return Alert(
                            title: Text("Success"),
                            message: Text("Pro version restored successfully"),
                            dismissButton: .default(
                                Text("OK"),
                                action: {
                                    showAlert = false
                                    //purchasedStatusMonthly = 1
                                }
                            )
                        )
                        
                    }
                }
        }
    }
    
    
    var fullScreenData:some View{

        ZStack{
            Color.BGCOLOR
                .ignoresSafeArea()
            VStack{
                HeaderTitle
                Spacer()
                VStack(spacing: 20){
                    descriptionItem
                        .padding(.horizontal,20)
                    privacyPolicy
                    purchaseBtns
                }
            }
        }
        .onAppear {
            subscriptionManager.fetchProductPrice(for: monthlyAIPId) { result in
                switch result {
                case .success(let price):
                    // Update UI with the product price
                    self.price = "\(price.currencyCode)\(price.price)"
                case .failure(let error):
                    // Handle error
                    print("Failed to fetch product price: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    
    var HeaderTitle:some View{
        HStack {
            Text("")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            Button {
                crossTapped?()
            } label: {
                Image(systemName: "multiply.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                
            }
        }
        .padding(.horizontal, 20)
    }

    var descriptionItem:some View{

        VStack(spacing: 50){

            Image("botIcon")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("Say hello to Thready.")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("Go Premium and you will get unlimited usages, purchase points to get credit to access the premium features. Credit never expires so no need to worry about weekly/monthly subscription.Get 100, 500 or 1000 points now!")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.system(size: 15))
        }
    }
    
    
    var privacyPolicy: some View{
        
        VStack(spacing: 50){
            Divider()
                .background(Color.gray)
            VStack(spacing: 10){
                Button {
                    restoreTapped()
                } label: {
                    Text("Restore Purchases")
                        .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                HStack{
                    
                    Button {
                        termsAndConditionTapped()
                    } label: {
                        Text("Terms & Conditions")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12))
                    }
                    
                    Button {
                        termsAndConditionTapped()
                    } label: {
                        Text("Privacy Policy")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12))
                    }
                    
                }
            }
        }.padding(.top,50)
    }
    
    
    var purchaseBtns:some View{
        VStack(spacing: 20){
            
            HStack {
                Text("Basic")
                    .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(price)
                
                    .foregroundColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                
            }
            .padding(.horizontal, 10)
            .frame(height: 60)
            .background(Color.APPERANCEUNSELECTEDBGCOLOR)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.getCurrentColor(PRIMARYCOLORVALUE), lineWidth: 2)
            )
            
            Button(action: {
                purchaseProTapped()
            }) {
                Text("Purchase Pro Version")
                    .frame(height: 60)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

            }
            .frame(maxWidth: .infinity)
            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .cornerRadius(10)
            

        }.padding(.horizontal,20)
        
        
    }

}


extension MonthlySubscription{

    func whatInclude(){
        
    }
    
    func howToSubscrie(){
        
    }
    
    func restoreTapped(){
        isLoading = true
        
        
        subscriptionManager.restoreProduct { result in
            isLoading = false
            
            switch result {
            case .success(_):
                showAlert = true
                currentAlert = .restoredSuccess
                
            case .failure(let failure):
                failureError = failure.localizedDescription
                showAlert = true
                currentAlert = .error
            }
        }

        
    }
    
    func termsAndConditionTapped(){
        
    }
    
    
    func privacyPolicyTapped(){
        
    }
    
    func purchaseProTapped(){
        
        isLoading = true
        
        subscriptionManager.purchaseProduct(monthlyAIPId) { result in
            isLoading = false

            switch result {
            case .success(_):
                showAlert = true
                currentAlert = .success

            case .failure(let error):
                failureError = error.localizedDescription
                showAlert = true
                currentAlert = .error
                
            }
        }
        
    }
    
    
    
    
}


struct MonthlySubscription_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySubscription()
    }
}
