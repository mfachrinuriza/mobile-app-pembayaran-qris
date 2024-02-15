//
//  HomeInteractor.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import core

protocol HomeInteractorProtocol: AnyObject {
    func createTransaction(_ request: Transaction)
    func setAmount()
    func getAmount() -> Double
}

class HomeInteractor: HomeInteractorProtocol {
    internal let storage: StorageProtocol
    internal let secureStorage: SecureStorageProtocol

    init(
        storage: StorageProtocol,
        secureStorage: SecureStorageProtocol
    ) {
        self.storage = storage
        self.secureStorage = secureStorage
    }
    
    func setAmount() {
        storage.set(key: "amount", item: 100000)
    }
    
    func getAmount() -> Double {
        return storage.get(key: "amount", type: Double.self) ?? 0
    }
    
    func createTransaction(_ request: Transaction) {
        var list = storage.get(key: "transaction", type: [Transaction].self)
        list?.append(request)
        storage.set(key: "transaction", item: list)
    }
}
