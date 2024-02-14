//
//  HistoryCell.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import UIKit

class HistoryCell: UICollectionViewCell {

    @IBOutlet weak var merchantImage: UIImageView!
    
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var transactionID: UILabel!
    @IBOutlet weak var date: UILabel!
    
    static let cellIdentifier = "HistoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        merchantImage.layer.cornerRadius = merchantImage.frame.width / 2
    }
    
    func update(with trx: Transaction) {
        self.merchantName.text = trx.merchantName
        self.paymentMethod.text = trx.paymentMethod
        self.transactionID.text = trx.transactionId
        self.date.text = DateTime.getDateStringFromDate(date: trx.date ?? Date.now)
    }

}
