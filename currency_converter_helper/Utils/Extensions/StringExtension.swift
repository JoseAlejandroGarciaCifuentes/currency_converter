//
//  StringExtension.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var toDecimal: Decimal? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let number = formatter.number(from: self) else { return Decimal() }
        return number.decimalValue
    }
    
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter.number(from: self)?.doubleValue
    }
    
    func roundToHalfEven() -> String{
        if !self.contains("."){
            return self
        }

        let amountSplitted = self.split(separator: ".")
        
        if amountSplitted[1].count <= 2 {
            return self
        }
        
        var decimalsString = String(amountSplitted[1])
        let indexPosition = decimalsString.index(decimalsString.startIndex, offsetBy: 2)
        decimalsString.insert(".", at: indexPosition)
        
        let decimalsAsDouble = Double(decimalsString)
        let decimalsRounded = Double(lrint(decimalsAsDouble ?? Double())) / 100
        
        let amountInteger = Double(amountSplitted[0])!
        let roundedAmount = amountInteger + decimalsRounded
        
        return String(describing: roundedAmount)
        
    }
}
