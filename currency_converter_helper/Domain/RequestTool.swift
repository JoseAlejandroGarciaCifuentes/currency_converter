//
//  RequestTool.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation

enum HTTMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol Request {
    
    typealias HTTPHeaders = [String : String]
    
    var baseURL: String { get }
    var endpoint: String { get }
    var httpHeaders: HTTPHeaders { get }
    var params: [String: Any] { get }
    var httpMethod: HTTMethods { get }
    
}

extension Request {
    
    var baseURL: String { Constants.Domain.apiBaseUrl }
    var urlExtension: String { Constants.Domain.urlExtension }
    var httpMethod: HTTMethods { .get }
    var params: [String: Any] { [:] }
    var httpHeaders: HTTPHeaders { return ["Content-Type": "application/json", "Accept" : "application/json"] }
    
}
