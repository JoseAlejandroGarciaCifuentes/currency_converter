//
//  TransactionCell.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 23/6/22.
//

import UIKit

class TransactionCell: BaseCell {

    @IBOutlet weak var title: UILabel!
    
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
    func display(transactionName: String) {
        self.title.text = transactionName
    }

}
