//
//  NonConsumablePurchaseManager.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 5/2/23.
//

import Foundation
import StoreKit

class NonConsumablePurchaseManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK: - Properties
    
    static let shared = NonConsumablePurchaseManager()
    
    @Published var products = [SKProduct]()
    @Published var isFetchingProducts = false
    @Published var purchaseCompleted = false
    @Published var purchaseRestored = false
    @Published var purchaseError: Error?
    
    private var productIdentifiers: [String] = []
    private var productRequest: SKProductsRequest?
    private var purchaseCompletion: ((Bool, String?) -> Void)?
    
    //MARK: - Init
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    //MARK: - Public Methods
    
    func fetchProducts(_ productIDs: [String]) {
        isFetchingProducts = true
        productIdentifiers = productIDs
        productRequest = SKProductsRequest(productIdentifiers: Set(productIDs))
        productRequest?.delegate = self
        productRequest?.start()
    }
    
    func purchaseProduct(_ product: SKProduct, completion: @escaping (Bool, String?) -> Void) {
        purchaseCompletion = completion
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePurchases(completion: @escaping (Bool, String?) -> Void) {
        purchaseCompletion = completion
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func hasPurchasedProduct(_ productID: String) -> Bool {
        return UserDefaults.standard.bool(forKey: productID)
    }
    
    //MARK: - SKProductsRequestDelegate
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {

            var weekly : SKProduct?
            var monthly : SKProduct?
            var yearly : SKProduct?

            self.products = response.products
            for prod in self.products {
                if prod.productIdentifier == "Com.jeanpaul.mikeyaiassistant.weekly" {
                    weekly = prod
                }else if prod.productIdentifier == "Com.jeanpaul.mikeyaiassistant.monthly2" {
                    monthly = prod
                }else if prod.productIdentifier == "Com.jeanpaul.mikeyaiassistant.yearly" {
                    yearly = prod
                }else {

                }
            }
            self.products.removeAll()
            self.products.append(weekly ?? SKProduct())
            self.products.append(monthly ?? SKProduct())
            self.products.append(yearly ?? SKProduct())

            self.isFetchingProducts = false
            self.productRequest = nil
        }
    }


    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        isFetchingProducts = false
        productRequest = nil
    }
    
    //MARK: - SKPaymentTransactionObserver
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                completeTransaction(transaction)
                purchaseCompleted = true
                purchaseCompletion?(true, nil)
                purchaseCompletion = nil
            case .failed:
                failTransaction(transaction)
                purchaseError = transaction.error
                purchaseCompletion?(false, getReadableError(transaction))
                purchaseCompletion = nil
            case .restored:
                completeTransaction(transaction)
                purchaseCompleted = true
                purchaseCompletion?(true, nil)
                purchaseCompletion = nil
                
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        purchaseError = error
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        purchaseRestored = true
    }
    
    //MARK: - Private Methods
    
    private func completeTransaction(_ transaction: SKPaymentTransaction) {
        UserDefaults.standard.set(true, forKey: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func failTransaction(_ transaction: SKPaymentTransaction) {
        if let error = transaction.error as? SKError, error.code != .paymentCancelled {
            print("Transaction failed: \(error.localizedDescription)")
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func getReadableError(_ transaction: SKPaymentTransaction)->String{
        if let error = transaction.error as? SKError {
            switch error.code {
            case .paymentCancelled:
                return "Transaction cancelled."
            case .paymentInvalid:
                return "Transaction invalid."
            case .paymentNotAllowed:
                return "Transaction not allowed."
            case .storeProductNotAvailable:
                return "Product not available in the current storefront."
            case .cloudServicePermissionDenied:
                return "Access to cloud service information is not allowed."
            case .cloudServiceNetworkConnectionFailed:
                return "Unable to connect to the network for cloud service information."
            case .cloudServiceRevoked:
                return "Cloud service information was revoked."
            case .privacyAcknowledgementRequired:
                return "User has not acknowledged Apple's privacy policy."
            case .unauthorizedRequestData:
                return "Unable to authorize the request data."
            case .invalidOfferIdentifier:
                return "The offer identifier is invalid."
            case .invalidSignature:
                return "The signature is invalid."
            case .missingOfferParams:
                return "Missing offer parameters."
            case .invalidOfferPrice:
                return "The offer price is invalid."
            case .overlayCancelled:
                return "The overlay window was cancelled."
            case .overlayInvalidConfiguration:
                return "The overlay window configuration is invalid."
            case .overlayTimeout:
                return "The overlay window timed out."
            case .unknown:
                return "Transaction failed with unknown error."
            @unknown default:
                return "Transaction failed with unknown error."
            }
        } else {
            return "Transaction failed with unknown error."
        }
    }
    
    
}
