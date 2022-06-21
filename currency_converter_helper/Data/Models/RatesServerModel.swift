//
//  RatesServerModel.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation

struct RatesServerModel: Codable {
    
    var from: String
    var to: String
    var rate: String
    
}
