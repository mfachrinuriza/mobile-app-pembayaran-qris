//
//  Transaction.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation

public struct Transaction: Codable {
    public var transactionId: String?
    public var paymentMethod: String?
    public var merchantName: String?
    public var amount: Double?
    public var date: Date?
    
    public init(
        transactionId: String? = nil,
        paymentMethod: String? = nil,
        merchantName: String? = nil,
        amount: Double? = nil,
        date: Date? = nil
    ) {
        self.transactionId = transactionId
        self.paymentMethod = paymentMethod
        self.merchantName = merchantName
        self.amount = amount
        self.date = date
    }
}
