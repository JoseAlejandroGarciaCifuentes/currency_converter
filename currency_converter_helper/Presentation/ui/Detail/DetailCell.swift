//
//  DetailCell.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 27/6/22.
//

import UIKit

class DetailCell: BaseCell {
    
    @IBOutlet weak var sku: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var originalAmount: UILabel!
    @IBOutlet weak var amountInEur: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     Displays configured cell
     - Parameter transaction: Transaction instance to be displayed
    */
    func display(transaction: TransactionWithEur, position: Int) {
        self.sku.text = String(describing: position.description)
        self.currency.text = transaction.currency
        self.originalAmount.text = setAmountWithSymbol(currency: Currencies(rawValue: transaction.currency) ?? .USD, amount: transaction.amount)
        self.amountInEur.text = transaction.amountInEur + " " + Constants.Symbols.eur
    }
    
    func setAmountWithSymbol(currency: Currencies, amount: String) -> String {
        switch currency {
        case .AUD, .CAD, .USD:
            return Constants.Symbols.dollar + amount
        case .EUR:
            return amount + " " + Constants.Symbols.eur
        }
    }

}
