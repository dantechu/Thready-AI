//
//  ProVersion.swift
//  ChatGptApp Watch App
//
//  Created by Hamza Butt on 5/3/23.
//

import SwiftUI
enum AlertType {
    case success
    case error
    case restoredSuccess
}



struct ProVersion: View {
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0
    let subscriptionManager = SubscriptionManager(productIDs: [monthlySubscriptionAIPIdWatch])
    
    
    @State var failureError = ""
    @State var price = "loading..."
    @State private var currentAlert: AlertType = .success
    
    @AppStorage(WATCHURCHASEDSTATUSMONTHLY) private var watchPurchasedStatusMonthly:Int = 0
    
    
    
    
    @State var isLoading = false
    @State var showAlert: Bool = false
    
    var dismissTapped:(()->Void)?
    
    
    
    var body: some View {
        ZStack {
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
                                    watchPurchasedStatusMonthly = 1
                                    dismissTapped?()
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
                                    watchPurchasedStatusMonthly = 1
                                    dismissTapped?()
                                }
                            )
                        )

                    }



        }
            
            
            
            ActivityIndicatorLoadingView(isShowing: $isLoading)
        }
        
        
        
    }
    
    
    
    var fullScreenData:some View{
        
        VStack(alignment: .leading,spacing: 12){
            
            
            HStack{
                Spacer()
                
                Text("Al Chat PRO")
                    .foregroundColor(.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 20))
                
                Spacer()
            }
            
            
            
            
            VStack(spacing: 5){
                
                HStack {
                    Image(systemName: "checkmark")
                    Text("Unlimited Question")
                        .font(.system(size: 14))
                }
                
                HStack {
                    Image(systemName: "checkmark")
                    Text("Higher Word Limit")
                        .font(.system(size: 14))
                }
                
            }
            
            
            
         
            Button {
                purchaseProTapped()
            } label: {
                Text(price)
            }
            .background(Color.getCurrentColor(PRIMARYCOLORVALUE))
            .cornerRadius(10, corners: .allCorners)


            
            
            
        }
        .onAppear {
            subscriptionManager.fetchProductPrice(for: monthlySubscriptionAIPIdWatch) { result in
                switch result {
                case .success(let price):
                    self.price = "\(price.currencyCode)\(price.price)/Month"
                case .failure(let error):
                    print("Failed to fetch product price: \(error.localizedDescription)")
                }
            }

            
        }
        
        
    }
    
    
    func purchaseProTapped(){
        
        isLoading = true
        
        subscriptionManager.purchaseProduct(monthlySubscriptionAIPIdWatch) { result in
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



struct ProVersion_Previews: PreviewProvider {
    static var previews: some View {
        ProVersion()
    }
}

