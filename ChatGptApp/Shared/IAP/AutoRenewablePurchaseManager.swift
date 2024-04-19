//
//  AutoRenewablePurchaseManager.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 5/2/23.
//

import Foundation
import StoreKit
import UIKit
protocol subcriptionDelegate {
    func productPurchased(val:Date)
}
class SubscriptionManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    private let productIDs: Set<String>
    private var productsRequest: SKProductsRequest?
    private var fetchPriceCompletion: ((Result<(price: String, currencyCode: String), Error>) -> Void)?
    private var purchaseCompletion: ((Result<Void, Error>) -> Void)?
    private var restoreCompletion: ((Result<Void, Error>) -> Void)?
    var delegate:subcriptionDelegate?
    private var products = [SKProduct]()
    
    init(productIDs: Set<String>) {
        self.productIDs = productIDs
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    // MARK: - Fetch Product Price
    
    
    func fetchProductPrice(for productID: String, completion: @escaping (Result<(price: String, currencyCode: String), Error>) -> Void) {
        guard SKPaymentQueue.canMakePayments() else {
            completion(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "In-app purchases are not available"])))
            return
        }
        
        guard productIDs.contains(productID) else {
            completion(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid product identifier"])))
            return
        }
        
        self.fetchPriceCompletion = completion
        let productIdentifiers = Set([productID])
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            let price = "\(product.price)"
            let currencyCode = product.priceLocale.currencySymbol ?? ""
            
            products = response.products
            fetchPriceCompletion?(.success((price: price, currencyCode: currencyCode)))
            
            
        } else if let invalidProductID = response.invalidProductIdentifiers.first {
            fetchPriceCompletion?(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid product identifier: \(invalidProductID)"])))
        } else {
            fetchPriceCompletion?(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
        }
        fetchPriceCompletion = nil
    }
    
    
    func checkSubscriptionStatus()-> Bool {
        if let purchase = UserDefaults.standard.value(forKey: "subscriptionPurchase") as? Date {
            if purchase < Date() {
                UserDefaults.standard.removeObject(forKey: "subscriptionPurchase")
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        fetchPriceCompletion?(.failure(error))
        fetchPriceCompletion = nil
    }
    
    // MARK: - Purchase Product
    
    func purchaseProduct(_ productID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard SKPaymentQueue.canMakePayments() else {
            completion(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "In-app purchases are not available"])))
            return
        }
        
        guard productIDs.contains(productID) else {
            completion(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid product identifier"])))
            return
        }
        
        guard !hasPurchased(productID: productID) else {
            completion(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "You have already purchased this item"])))
            return
        }
        
        self.purchaseCompletion = completion
        if let product = products.first {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    
    // MARK: - Restore Product
    
    func restoreProduct(completion: @escaping (Result<Void, Error>) -> Void) {
        guard SKPaymentQueue.canMakePayments() else {
            completion(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "In-app purchases are not available"])))
            return
        }
        
        self.restoreCompletion = completion
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: - Check if User Purchased Product
    
    func hasPurchased(productID: String) -> Bool {
        let transactions = StorageManager.retrieveTransactions()
        return transactions.contains(where: { $0.payment.productIdentifier == productID })
    }
    
    // MARK: - SKPaymentTransactionObserver
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction as SKPaymentTransaction
            let prodID = t.payment.productIdentifier as String
            switch prodID{
            case "IAP id":
                break
               // print("Remove Ads")
            default:
                break
               // print("IAP not setup")
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print(error)
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                complete(transaction: transaction)
                var val = Date().addingTimeInterval(30 * 24 * 60 * 60)
                UserDefaults.standard.set(val, forKey: "subscriptionPurchase")
                delegate?.productPurchased(val: val)
            case .failed:
                fail(transaction: transaction)
            case .restored:
                restore(transaction: transaction)
                UserDefaults.standard.set(Date().addingTimeInterval(30 * 24 * 60 * 60), forKey: "subscriptionPurchase")
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        StorageManager.store(transaction: transaction)
        SKPaymentQueue.default().finishTransaction(transaction)
        purchaseCompletion?(.success(()))
        purchaseCompletion = nil
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        if let error = transaction.error as? SKError, error.code == .paymentCancelled {
            purchaseCompletion?(.failure(NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Purchase cancelled"])))
        } else {
            purchaseCompletion?(.failure(transaction.error ?? NSError(domain: "SubscriptionManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
        }
        purchaseCompletion = nil
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func restore(transaction: SKPaymentTransaction) {
        StorageManager.store(transaction: transaction)
        SKPaymentQueue.default().finishTransaction(transaction)
        restoreCompletion?(.success(()))
        restoreCompletion = nil
    }
}



struct StorageManager {
    static func retrieveProducts() -> [SKProduct] {
        // Retrieve products from server or cache
        return []
    }
    
    static func store(transaction: SKPaymentTransaction) {
        // Store transaction on server or locally
    }
    
    static func retrieveTransactions() -> [SKPaymentTransaction] {
        // Retrieve transactions from server or locally
        return []
    }

}

