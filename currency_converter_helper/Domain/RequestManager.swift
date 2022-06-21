//
//  RequestManager.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation
import Combine

protocol RequestManagerProtocol: AnyObject {
    func requestGeneric<R: Request, T: Decodable>(request: R, entity: T.Type) -> AnyPublisher<[T], NetworkingError>
}

class RequestManager : RequestManagerProtocol {
    
    internal func requestGeneric<R: Request, T: Decodable>(request: R, entity: T.Type) -> AnyPublisher<[T], NetworkingError> {
    
        let data = try? JSONSerialization.data(withJSONObject: request.params, options: .prettyPrinted)
        let defaultSessionConfiguration = URLSessionConfiguration.default
        
        defaultSessionConfiguration.httpAdditionalHeaders = request.httpHeaders
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)
        var urlRequest = URLRequest(url: URL(string: request.endpoint)!)
        urlRequest.httpMethod = request.httpMethod.rawValue
        if request.httpMethod == .post { urlRequest.httpBody = data }
        
        return defaultSession
            .dataTaskPublisher(for: urlRequest)
            .mapError { error -> NetworkingError in
                NetworkingError(error: error)
            }
            .flatMap { data, response -> AnyPublisher<[T], NetworkingError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkingError(status: .badRequest)).eraseToAnyPublisher()
                }
                
                debugPrint("--> REQUEST: \(urlRequest.url?.description ?? "")" as NSString)
                debugPrint("--> HEADERS:\n \(request.httpHeaders)" as NSString)
                debugPrint("--> PARAMS:\n \(request.params)" as NSString)
                debugPrint("--> RESPONSE:\n \(String(bytes: data, encoding: .utf8) ?? "nil")" as NSString)
                
                if (200...299).contains(httpResponse.statusCode) {
                    return Just(data)
                        .decode(type: [T].self, decoder: JSONDecoder())
                        .mapError { error in
                            NetworkingError(status: .unableToParseRequest)
                        }
                        .eraseToAnyPublisher()
                }
                else if (400...499).contains(httpResponse.statusCode) {
                    do {
                        let beamModel = try JSONDecoder().decode(BeamModel.self, from: data)
                        return Fail(error: NetworkingError(errorCode: httpResponse.statusCode, description: beamModel.message ?? "")).eraseToAnyPublisher()
                    }
                    catch {
                        return Fail(error: NetworkingError(errorCode: httpResponse.statusCode)).eraseToAnyPublisher()
                    }
                }
                else {
                    return Fail(error: NetworkingError(errorCode: httpResponse.statusCode)).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
