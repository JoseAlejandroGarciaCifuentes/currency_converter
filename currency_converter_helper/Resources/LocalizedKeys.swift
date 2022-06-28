//
//  LocalizedKeys.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation

struct LocalizedKeys {
    
    struct General {
        static let error = "Error"
        static let ok = "OK"
    }
    
    struct Main {
        static let title = "Home".localized
        static let uniqueTransactions = "unique transactions".localized
    }
    
    struct Details {
        static let title = "Detail".localized
        static let showing = "Showing".localized
        static let results = "results".localized
        static let sku = "SKU"
        static let total = "Total:"
    }
}
