//
//  DetailViewState.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 23/6/22.
//

import Foundation

enum DetailViewState {
    case loading
    case displayInfo(transactions: [TransactionWithEur], totalSum: String)
    case success
    case error
}

extension DetailViewState : Equatable {
    static func == (lhs: DetailViewState, rhs: DetailViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.displayInfo(let transactions1, let totalSum1), .displayInfo(let transactions2, let totalSum2)): return (transactions1 == transactions2 && totalSum1 == totalSum2) ? true : false
        case (.success, .success): return true
        case (.error, .error): return true
        default:
            return false
        }
    }
}
