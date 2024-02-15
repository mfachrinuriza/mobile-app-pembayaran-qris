//
//  TransactionDetailViewController.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import UIKit
import core

protocol TransactionDetailViewControllerProtocol where Self: UIViewController {
    var presenter: TransactionDetailPresenterProtocol { get }
    var router: TransactionDetailRouterProtocol { get }
    
    var idTrx: String? { get set }
    
    func update(with trx: Transaction)
}

class TransactionDetailViewController: BaseViewController, TransactionDetailViewControllerProtocol {

    var idTrx: String?
    
    @IBOutlet weak var trxDate: UILabel!
    @IBOutlet weak var trxId: UILabel!
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var paymentMethod: UILabel!
    
    internal let presenter: TransactionDetailPresenterProtocol
    internal let router: TransactionDetailRouterProtocol
    
    init(
        presenter: TransactionDetailPresenterProtocol,
        router: TransactionDetailRouterProtocol
    ) {
        self.presenter = presenter
        self.router = router
        

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.setNavigationBarWithoutTitle()
        self.loadData()
    }
    
    func loadData() {
        self.presenter.getTransactionDetail(idTrx ?? "")
    }
    
    func update(with trx: Transaction) {
        self.trxDate.text = DateTime.getDateStringFromDate(date: trx.date ?? Date())
        self.trxId.text = trx.transactionId
        self.merchantName.text = trx.merchantName
        self.amount.text = "\(trx.amount?.f(.currency) ?? "")"
        self.paymentMethod.text = trx.paymentMethod
    }
}
