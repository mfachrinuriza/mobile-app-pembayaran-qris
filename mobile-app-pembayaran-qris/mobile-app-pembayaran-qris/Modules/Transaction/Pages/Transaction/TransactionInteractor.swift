//
//  TransactionInteractor.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import core

protocol TransactionInteractorProtocol: AnyObject {
    func createTransaction(_ request: Transaction) -> Void
    func getAmount() -> Double
}

class TransactionInteractor: TransactionInteractorProtocol {
    internal let storage: StorageProtocol
    internal let secureStorage: SecureStorageProtocol

    init(
        storage: StorageProtocol,
        secureStorage: SecureStorageProtocol
    ) {
        self.storage = storage
        self.secureStorage = secureStorage
    }
    
    func createTransaction(_ request: Transaction) -> Void {
        var list = storage.get(key: "transaction", type: [Transaction].self) ?? []
        list.append(request)
        storage.set(key: "transaction", item: list)
        onCalculateAmount(transaction: request)
    }
    
    func onCalculateAmount(transaction: Transaction) {
        var amount = getAmount()
        amount = amount - (transaction.amount ?? 0)
        storage.set(key: "amount", item: amount)
    }
    
    func getAmount() -> Double {
        return storage.get(key: "amount", type: Double.self) ?? 0
    }
}
