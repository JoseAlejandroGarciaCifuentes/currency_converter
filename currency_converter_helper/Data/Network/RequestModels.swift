//
//  RequestModels.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation

struct RatesRequest: Request {
    var endpoint: String { baseURL + Constants.Endpoints.rates }
    var httpHeaders: HTTPHeaders { [Constants.Headers.contentType: Constants.Headers.applicationJson, Constants.Headers.accept : Constants.Headers.applicationJson] }
}

struct TransactionsRequest: Request {
    var endpoint: String { baseURL + Constants.Endpoints.transactions }
    var httpHeaders: HTTPHeaders { [Constants.Headers.contentType: Constants.Headers.applicationJson, Constants.Headers.accept : Constants.Headers.applicationJson] }
}
