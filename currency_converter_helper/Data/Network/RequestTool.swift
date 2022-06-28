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
    
    var baseURL: String { Constants.Api.apiBaseUrl }
    var urlExtension: String { Constants.Api.urlExtension }
    var httpMethod: HTTMethods { .get }
    var params: [String: Any] { [:] }
    var httpHeaders: HTTPHeaders { return [Constants.Headers.contentType: Constants.Headers.applicationJson, Constants.Headers.accept : Constants.Headers.applicationJson] }
    
}
