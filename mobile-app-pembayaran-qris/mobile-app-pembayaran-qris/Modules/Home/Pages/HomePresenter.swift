//
//  HomePresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import Combine
import core

protocol HomePresenterProtocol: AnyObject {
    var interactor: HomeInteractorProtocol { get }

    var router: HomeRouterProtocol? { get set }
    var view: HomeViewControllerProtocol? { get set }
    var isFlashOn: CurrentValueSubject<Bool, Never> { get }
    
    func setAmount()
    func getAmount()
}

class HomePresenter: HomePresenterProtocol {
    internal let interactor: HomeInteractorProtocol
    
    weak var router: HomeRouterProtocol?
    weak var view: HomeViewControllerProtocol?
    
    let isFlashOn = CurrentValueSubject<Bool, Never>(false)
    let qrData = CurrentValueSubject<Transaction?, Never>(nil) 
    
    init(
        interactor: HomeInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func setAmount() {
        if interactor.getAmount() == 0 {
            self.interactor.setAmount()
        }
    }
    
    func getAmount() {
        self.view?.update(with: self.interactor.getAmount()) 
    }
}
