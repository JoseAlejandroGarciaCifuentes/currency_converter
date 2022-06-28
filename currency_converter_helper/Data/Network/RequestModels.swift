//
//  RequestModels.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation

struct RatesRequest: Request {
    var endpoint: String { baseURL + "rates" }
    var httpHeaders: HTTPHeaders { ["Content-Type": "application/json", "Accept" : "application/json"] }
}

struct TransactionsRequest: Request {
    var endpoint: String { baseURL + "transactions" }
    var httpHeaders: HTTPHeaders { ["Content-Type": "application/json", "Accept" : "application/json"] }
}