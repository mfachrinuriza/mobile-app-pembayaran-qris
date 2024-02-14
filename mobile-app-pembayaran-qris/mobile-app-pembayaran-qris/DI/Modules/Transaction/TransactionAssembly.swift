//
//  TransactionAssembly.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Swinject
import SwinjectAutoregistration

class TransactionAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(TransactionInteractorProtocol.self, initializer: TransactionInteractor.init)
        container.autoregister(TransactionRouterProtocol.self, initializer: TransactionRouter.init)
        container.autoregister(TransactionPresenterProtocol.self, initializer: TransactionPresenter.init)

        container.register(TransactionViewControllerProtocol.self) { r in
            let presenter = r.resolve(TransactionPresenterProtocol.self)!
            let router = r.resolve(TransactionRouterProtocol.self)!
            let view = TransactionViewController(
                presenter: presenter,
                router: router
            )
            
            presenter.view = view
            presenter.router = router
            router.view = view
            
            return view
        }

    }
    
}
