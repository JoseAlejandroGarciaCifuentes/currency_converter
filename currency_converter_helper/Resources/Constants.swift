//
//  Constants.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation

struct Constants {
    
    struct Symbols {
        static let eur = "€"
        static let dollar = "$"
    }
    struct Api {
        static let apiBaseUrl = "http://quiet-stone-2094.herokuapp.com/"
        static let urlExtension = ".json"
    }
    
    struct Endpoints {
        static let rates = "rates"
        static let transactions = "transactions"
    }
    
    struct Headers {
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
        static let accept = "Accept"
    }
    
    struct DI {
        static let MainNavController = "MainNavController"
    }
    
    struct Storyboard {
        static let main = "Main"
    }
    
    struct ViewController {
        static let mainVC = "MainVC"
        static let detailVC = "DetailVC"
    }
    
    struct cellIds {
        static let transactionCell = "transactionCell"
        static let detailCell = "detailCell"
    }
}
