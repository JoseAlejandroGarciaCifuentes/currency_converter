//
//  CurrencyConverter.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 23/6/22.
//

import Foundation
import Combine

enum Currencies: String {
    case AUD
    case CAD
    case USD
    case EUR
}

protocol CurrencyConverterProtocol {
    var delegate: CurrencyConverterDelegate? { get set }
    
    func getRates()
    func getAmountInEur(currency: Currencies, amount: Double) -> Double
}

protocol CurrencyConverterDelegate {
    func onSuccess()
    func onLoading()
    func onError(_ error: String)
}

class CurrencyConverter: CurrencyConverterProtocol {
    
    var delegate: CurrencyConverterDelegate?
    
    private let provider: Provider
    private var rates: [Rate]
    private var cancellable: Set<AnyCancellable> = []
    
    init(provider: Provider) {
        self.provider = provider
        self.rates = []
    }
    
    /**
     Checks the available conversions and converts the currency until its in EUR
     Returns: Amount Converted in Eur
     */
    func getAmountInEur(currency: Currencies, amount: Double) -> Double {
        if currency == .EUR { return amount }
        
        let ratesWithCurrency = getAllRates(with: currency) //Fetches all rates that contains the currency in the <<from>> var
        
        if ratesWithCurrency.contains(where: { $0.to == Currencies.EUR.rawValue}) { //Weather the rate has an EUR conversion
            return convertAmount(from: currency, to: .EUR, amount: amount)
        } else { // or not
            
            let toRates = ratesWithCurrency.map({ $0.to }).uniqued()
            
            //test "to" variables if any converts to EUR
            if let rateConvertsToEUR = getRateThatConvertsToEur(fromRates: toRates) {
                guard let newCurrency = Currencies(rawValue: rateConvertsToEUR.from) else { return Double() }
                let amountConverted = convertAmount(from: newCurrency, to: .EUR, amount: amount)
                return getAmountInEur(currency: newCurrency, amount: amountConverted)
            } else {
                
                guard let newCurrency = Currencies(rawValue: toRates.first ?? Currencies.USD.rawValue) else { return Double() }
                let amountConverted = convertAmount(from: newCurrency, to: .EUR, amount: amount)
                return getAmountInEur(currency: Currencies(rawValue: toRates.first ?? Currencies.USD.rawValue) ?? .USD, amount: amountConverted)
            
            }
        }
    }
    /**
     Retrieves all rates that contains the currency in the "from" property
     */
    func getAllRates(with currency: Currencies) -> [Rate] {
        return rates.filter({ $0.from == currency.rawValue })
    }
    
    /**
     Returns the rate that contains eur as in the "to" property
     */
    func getRateThatConvertsToEur(fromRates: [String]) -> Rate? {
        return rates.first { rate in
            fromRates.contains(where: { $0 == rate.from && rate.to == Currencies.EUR.rawValue })
        }
    }
    
    /**
     Converts the amount from one currency to another given
     Returns: new amount converted as Double
     */
    private func convertAmount(from: Currencies, to: Currencies, amount: Double) -> Double {
        var newAmount = amount
        
        if let rateExchange = rates.first(where: { $0.from == from.rawValue && $0.to == to.rawValue })?.rate.toDouble() {
            newAmount *= rateExchange
        }
        
        return newAmount
    }
    
    /**
     Fetches all rates from the api
     */
    internal func getRates() {
        delegate?.onLoading()
        self.provider.requestRates()
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion {
                    case .finished: break
                case .failure(let error):
                    self?.delegate?.onError(error.errorDescription ?? "")
                }
            } receiveValue: { [weak self] response in
                guard self != nil else { return }
                response.forEach { rate in
                    self?.rates.append(Rate(rate))
                }
                
                self?.delegate?.onSuccess()
            }
            .store(in: &cancellable)

    }
}
