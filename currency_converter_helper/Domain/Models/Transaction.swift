//
//  Transaction.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 23/6/22.
//

import Foundation

struct Transaction: Hashable {
    var sku: String
    var amount: String
    var currency: String
    
    init(_ transactionServerModel: TransactionServerModel) {
        self.sku = transactionServerModel.sku
        self.amount = transactionServerModel.amount
        self.currency = transactionServerModel.currency
    }
}

extension Transaction: Equatable {
  static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
    return lhs.sku == rhs.sku
  }
}


struct TransactionWithEur: Hashable {
    var sku: String
    var amount: String
    var amountInEur: String
    var currency: String
    
    init(transaction: Transaction, amountInEur: String) {
        self.sku = transaction.sku
        self.amount = transaction.amount
        self.currency = transaction.currency
        self.amountInEur = amountInEur
    }
}
