//
//  TransactionRouter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation

protocol TransactionRouterProtocol: AnyObject {
    var view: TransactionViewControllerProtocol? { get set }
    
    func presentTrasanctionDetail(_ idTrx: String) -> Void
}

class TransactionRouter: TransactionRouterProtocol {
    weak var view: TransactionViewControllerProtocol?
    
    func presentTrasanctionDetail(_ idTrx: String) -> Void {
        let vc = DI.get(TransactionDetailViewControllerProtocol.self)!
        vc.idTrx = idTrx
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
