//
//  Rates.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 23/6/22.
//

import Foundation

struct Rate: Equatable {
    var from: String
    var to: String
    var rate: String
    
    init(_ rate: RatesServerModel) {
        self.from = rate.from
        self.to = rate.to
        self.rate = rate.rate
    }
}
