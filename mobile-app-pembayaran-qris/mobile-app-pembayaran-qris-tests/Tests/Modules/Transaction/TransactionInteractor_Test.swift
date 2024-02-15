//
//  TransactionInteractor_Test.swift
//  mobile-app-pembayaran-qris-tests
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import XCTest
import core
import Swinject
import SwinjectAutoregistration
@testable import mobile_app_pembayaran_qris

final class TransactionInteractor_Test: XCTestCase {
    let container = Container()
 
    override func setUpWithError() throws {
        // Storage
        container.autoregister(StorageProtocol.self, initializer: Storage.init)
        container.autoregister(SecureStorageProtocol.self, initializer: SecureStorage.init)

        // Home Interactor
        container.autoregister(TransactionInteractorProtocol.self, initializer: TransactionInteractor.init)
    }
    
    override func tearDownWithError() throws {
        container.removeAll()
    }

    func test_createTransaction_success() async throws {
        let transactionInteractor = container ~> TransactionInteractorProtocol.self
        let homeInteractor = container ~> HomeInteractorProtocol.self
        let storage = container ~> StorageProtocol.self
        
        _ = homeInteractor.setAmount()
        
        _ = transactionInteractor.createTransaction(
            Transaction(
                transactionId: "ID12345678",
                paymentMethod: "BNI",
                merchantName: "MERCHANT MOCK TEST",
                amount: 50000
            )
        )
        
        let transaction = storage.get(key: "transaction", type: Transaction.self)
        XCTAssertNotNil(transaction)
        
        let amount = storage.get(key: "amount", type: Double.self)
        XCTAssertEqual(amount, 50000)
    }

}
