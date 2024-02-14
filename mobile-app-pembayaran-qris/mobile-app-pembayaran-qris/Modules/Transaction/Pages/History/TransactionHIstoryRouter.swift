//
//  TransactionHIstoryRouter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation

protocol TransactionHistoryRouterProtocol: AnyObject {
    var view: TransactionHistoryViewControllerProtocol? { get set }
    
    func presentTrasanctionDetail(_ idTrx: String) -> Void
}

class TransactionHistoryRouter: TransactionHistoryRouterProtocol {
    weak var view: TransactionHistoryViewControllerProtocol?
    
    func presentTrasanctionDetail(_ idTrx: String) -> Void {
        let vc = DI.get(TransactionDetailViewControllerProtocol.self)!
        vc.idTrx = idTrx
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
