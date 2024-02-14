//
//  TransactionDetailPresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation
import Combine

protocol TransactionDetailPresenterProtocol: AnyObject {
    var interactor: TransactionDetailInteractorProtocol { get }

    var router: TransactionDetailRouterProtocol? { get set }
    var view: TransactionDetailViewControllerProtocol? { get set }

    func getTransactionDetail(_ idTrx: String)
}

class TransactionDetailPresenter: TransactionDetailPresenterProtocol {
    internal let interactor: TransactionDetailInteractorProtocol
    
    weak var router: TransactionDetailRouterProtocol?
    weak var view: TransactionDetailViewControllerProtocol?
    
    let isFlashOn = CurrentValueSubject<Bool, Never>(false)
    
    init(
        interactor: TransactionDetailInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func getTransactionDetail(_ idTrx: String) {
        let trx = self.interactor.getTransactionDetail(idTrx)
        self.view?.update(with: trx)
    }
}
