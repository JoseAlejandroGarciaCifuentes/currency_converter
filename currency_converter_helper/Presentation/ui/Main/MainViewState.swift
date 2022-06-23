//
//  MainViewState.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 22/6/22.
//

import Foundation

enum MainViewState {
    case loading
    case displayTransactions(transactions: [Transaction])
    case openDetails
}

extension MainViewState : Equatable {
    static func == (lhs: MainViewState, rhs: MainViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.displayTransactions(let transaction1), .displayTransactions(let transaction2)): return (transaction1 == transaction2) ? true : false
        case (.openDetails, .openDetails): return true
        default:
            return false
        }
    }
}
