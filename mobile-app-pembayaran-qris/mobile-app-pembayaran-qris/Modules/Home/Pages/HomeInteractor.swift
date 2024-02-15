//
//  HomeInteractor.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import core

protocol HomeInteractorProtocol: AnyObject {
    func createTransaction(_ request: Transaction) -> Void
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
    
    func createTransaction(_ request: Transaction) -> Void {
        var list = storage.get(key: "transaction", type: [Transaction].self)
        list?.append(request)
        storage.set(key: "transaction", item: list)
    }
}
