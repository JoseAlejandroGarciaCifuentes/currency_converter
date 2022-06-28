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
    struct Domain {
        static let apiBaseUrl = "http://quiet-stone-2094.herokuapp.com/"
        static let urlExtension = ".json"
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
