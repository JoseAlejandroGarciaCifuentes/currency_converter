//
//  Provider.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation
import Combine

class Provider {
    
    let rm : RequestManagerProtocol = RequestManager()
    
    internal func requestRates() -> AnyPublisher<[RatesServerModel], NetworkingError> {
        
        return self.rm.requestGeneric(request: RatesRequest(), entity: RatesServerModel.self)
            .map { response in
                return Just(response)
                    .setFailureType(to: NetworkingError.self)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    internal func requestTransactions() -> AnyPublisher<[TransactionServerModel], NetworkingError> {
        
        return self.rm.requestGeneric(request: TransactionsRequest(), entity: TransactionServerModel.self)
            .map { response in
                return Just(response)
                    .setFailureType(to: NetworkingError.self)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
