//
//  TransactionHIstoryPresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import UIKit

import Foundation
import Combine

protocol TransactionHistoryPresenterProtocol: AnyObject {
    var interactor: TransactionHistoryInteractorProtocol { get }

    var router: TransactionHistoryRouterProtocol? { get set }
    var view: TransactionHistoryViewControllerProtocol? { get set }

    func getTransactionHistory()
}

class TransactionHistoryPresenter: TransactionHistoryPresenterProtocol {
    internal let interactor: TransactionHistoryInteractorProtocol
    
    weak var router: TransactionHistoryRouterProtocol?
    weak var view: TransactionHistoryViewControllerProtocol?
    
    let isFlashOn = CurrentValueSubject<Bool, Never>(false)
    
    init(
        interactor: TransactionHistoryInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func getTransactionHistory() {
        let history: [Transaction] = self.interactor.getTransactionHistory()
        self.view?.update(with: history)
    }
}
