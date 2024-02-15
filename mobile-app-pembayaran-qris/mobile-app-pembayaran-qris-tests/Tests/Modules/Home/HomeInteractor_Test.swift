//
//  HomeInteractor_Test.swift
//  mobile-app-pembayaran-qris-tests
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import XCTest
import core
import Swinject
import SwinjectAutoregistration
@testable import mobile_app_pembayaran_qris

final class HomeInteractor_Test: XCTestCase {
    let container = Container()
 
    override func setUpWithError() throws {
        // Storage
        container.autoregister(StorageProtocol.self, initializer: Storage.init)
        container.autoregister(SecureStorageProtocol.self, initializer: SecureStorage.init)

        // Home Interactor
        container.autoregister(HomeInteractorProtocol.self, initializer: HomeInteractor.init)
    }
    
    override func tearDownWithError() throws {
        container.removeAll()
    }
    
    func test_getAmount_success() {
        let sut = container ~> HomeInteractorProtocol.self
        sut.setAmount()
        let amount = sut.getAmount()
        
        XCTAssertEqual(100000, amount)
    }
}
