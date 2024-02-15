//
//  TransactionPresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import Combine
import core

protocol TransactionPresenterProtocol: AnyObject {
    var interactor: TransactionInteractorProtocol { get }

    var router: TransactionRouterProtocol? { get set }
    var view: TransactionViewControllerProtocol? { get set }

    func createTransaction(_ request: Transaction)
    
}

class TransactionPresenter: TransactionPresenterProtocol {
    internal let interactor: TransactionInteractorProtocol
    
    weak var router: TransactionRouterProtocol?
    weak var view: TransactionViewControllerProtocol?
    
    init(
        interactor: TransactionInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func createTransaction(_ request: Transaction) {
        self.interactor.createTransaction(request)
        self.router?.presentTrasanctionDetail(request.transactionId ?? "")
    }
}
