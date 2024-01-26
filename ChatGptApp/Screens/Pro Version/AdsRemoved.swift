//
//  Pro Version.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 5/2/23.
//

import SwiftUI

struct AdsRemoved: View {
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    @AppStorage(PURCHASEDSTATUSLIFETIME) private var purchaseStatusLifeTime:Int = 0
    
    @StateObject var purchaseManager = NonConsumablePurchaseManager.shared
    @State var isLoading = false
    @State var showAlert: Bool = false
    @State private var currentAlert: AlertType = .success
    @State var failureError = ""
    
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
                                    purchaseStatusLifeTime = 1
                                    crossTapped?()
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
                                    purchaseStatusLifeTime = 1
                                    crossTapped?()
                                }
                            )
                        )
                        
                    }
                    
                    
                    
                }
            
        }
        
        
        
    }
    
    var fullScreenData: some View {
        ZStack {
            Color.BGCOLOR
                .ignoresSafeArea()

            VStack {
                HeaderTitle
                Spacer()

                ScrollView {
                    VStack(spacing: 20) {
                        descriptionItem
                            .padding(.horizontal, 20)

                        privacyPolicy

                        purchaseBtns
                            .frame(maxWidth: .infinity) // Ensure buttons don't go beyond the screen width
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        .onAppear {
            purchaseManager.fetchProducts([weeklyAIPId, monthlyAIPId, yearlylyAIPId])
        }
    }
    
    
    var HeaderTitle:some View{
        HStack {
            Text("        Thready")
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
            
            Text("Say hello to Thready")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Go Premium and you will get unlimited usages, pro features and removal of ads. Pay a weekly, monthly, or yearly fee and Cancel anytime.")
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
    
    var purchaseBtns: some View {
        VStack(spacing: 16) {

            Button(action: {
                purchaseWeeklyTapped()
            }) {
                HStack {
                    Text(" Purchase Weekly ")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                    if purchaseManager.products.count > 0 {
                        Text("\(purchaseManager.products.first?.priceLocale.currencySymbol ?? "$") \(purchaseManager.products.first?.price ?? 0)/Week  ")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }else{
                        Text("N/A  ")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60) // Adjust the button height as needed
            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .cornerRadius(10)

            Button(action: {
               purchaseMonthlyTapped()
            }) {
                HStack {
                    Text(" Purchase Monthly")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                    if purchaseManager.products.count > 1 {
                        Text("\(purchaseManager.products[1].priceLocale.currencySymbol ?? "$") \(purchaseManager.products[1].price )/Month  ")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }else{
                        Text("N/A  ")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)

                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60) // Adjust the button height as needed
                .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
                .cornerRadius(10)
            }

            Button(action: {
                purchaseYearlyTapped()
            }) {
                HStack {
                    Text(" Purchase Yearly")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()

                    if purchaseManager.products.count > 2 {
                        Text("\(purchaseManager.products[2].priceLocale.currencySymbol ?? "$") \(purchaseManager.products[2].price )/Year  ")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }else{
                        Text("N/A  ")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)

                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60) // Adjust the button height as needed
            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .cornerRadius(10)
        }
        .padding(.horizontal, 20)
    }



    
    
    
    
}


extension AdsRemoved{
    
    
    func whatInclude(){
        
    }
    
    func howToSubscrie(){
        
    }
    
    func restoreTapped(){
        isLoading = true
        purchaseManager.restorePurchases { success, error in
            isLoading = false
            if success {
                showAlert = true
                currentAlert = .restoredSuccess
                
            } else {
                failureError = error ?? ""
                showAlert = true
                currentAlert = .error
            }
        }
    }
    
    func termsAndConditionTapped(){
        
    }
    
    
    func privacyPolicyTapped(){
        
    }
    
    func purchaseWeeklyTapped(){
        
        isLoading = true
        guard let productToPurchase = purchaseManager.products.first else { return }
        purchaseManager.purchaseProduct(productToPurchase) { success, error in
            isLoading = false
            if success {
                showAlert = true
                currentAlert = .success

            } else {
                failureError = error ?? ""
                showAlert = true
                currentAlert = .error

            }
        }
    }

    func purchaseMonthlyTapped(){
        isLoading = true
        let productToPurchase = purchaseManager.products[1]
        purchaseManager.purchaseProduct(productToPurchase) { success, error in
            isLoading = false
            if success {
                showAlert = true
                currentAlert = .success

            } else {
                failureError = error ?? ""
                showAlert = true
                currentAlert = .error

            }
        }

    }

    func purchaseYearlyTapped(){
        isLoading = true
        let productToPurchase = purchaseManager.products[2]
        purchaseManager.purchaseProduct(productToPurchase) { success, error in
            isLoading = false
            if success {
                showAlert = true
                currentAlert = .success

            } else {
                failureError = error ?? ""
                showAlert = true
                currentAlert = .error
            }
        }

    }
    
    
    
    
}

struct AdsRemoved_Previews: PreviewProvider {
    static var previews: some View {
        AdsRemoved()
    }
}
