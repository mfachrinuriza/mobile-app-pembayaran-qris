//
//  TransactionViewController.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import UIKit
import core

protocol TransactionViewControllerProtocol where Self: UIViewController {
    var presenter: TransactionPresenterProtocol { get }
    var router: TransactionRouterProtocol { get }
    
    var trxData: Transaction? { get set }
    
    func createTransactionSuccess()
}

class TransactionViewController: BaseViewController, TransactionViewControllerProtocol {

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var transactionId: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var underlineAmount: UIImageView!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var rp: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var formBottomAnchor: NSLayoutConstraint!
    
    internal let presenter: TransactionPresenterProtocol
    internal let router: TransactionRouterProtocol
    
    var trxData: Transaction?
    
    init(
        presenter: TransactionPresenterProtocol,
        router: TransactionRouterProtocol
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
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.setNavigationBarWithTitle(title: "Pembayaran")
    }
    
    func setupUI() {
        storeImage.layer.cornerRadius = storeImage.frame.width / 2
        
        rp.layer.borderWidth = 1
        rp.layer.borderColor = Color.getColor(name: .black10)?.cgColor
        rp.layer.cornerRadius = rp.frame.width / 2
        rp.layer.masksToBounds = true
        
        self.storeName.text = trxData?.merchantName
        self.bankName.text = trxData?.paymentMethod
        self.transactionId.text = trxData?.transactionId
        self.amount.text = "\(trxData?.amount?.f(.number) ?? "")"
    }
    
    func createTransactionSuccess() {
        self.router.presentTrasanctionDetail(trxData?.transactionId ?? "")
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        if var data = trxData {
            data.date = Date.now
            self.presenter.createTransaction(data)
        } else {
            self.showAlert(title: Wording.error.uppercased(), message: Wording.systemError.capitalized)
        }
    }
}

