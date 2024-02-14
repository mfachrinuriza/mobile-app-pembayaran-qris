//
//  TransactionHistoryInteractor.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation

protocol TransactionHistoryInteractorProtocol: AnyObject {
    func getTransactionHistory() -> [Transaction]
    func getTransactionDetail(_ idTrx: String) -> Transaction 
}

class TransactionHistoryInteractor: TransactionHistoryInteractorProtocol {
    internal let storage: StorageProtocol
    internal let secureStorage: SecureStorageProtocol

    init(
        storage: StorageProtocol,
        secureStorage: SecureStorageProtocol
    ) {
        self.storage = storage
        self.secureStorage = secureStorage
    }
    
    func getTransactionHistory() -> [Transaction] {
        let trxList: [Transaction]? = storage.get(key: "transaction", type: [Transaction].self)
        return trxList ?? [Transaction]()
    }
    
    func getTransactionDetail(_ idTrx: String) -> Transaction {
        let trxStorage: [Transaction]? = storage.get(key: "transaction", type: [Transaction].self)
        var result = Transaction()
        
        if let trxlist = trxStorage {
            for trx in trxlist where trx.transactionId == idTrx {
                result = trx
                break
            }
        }
        
        return result
    }
}
