//
//  TargetAssembly.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation
import Swinject

final class TargetAssembly: Assembly {
    
    func assemble(container: Container) {
        registerProvider(container: container)
        registerCurrencyConverter(container: container)
        registerMainViewModel(container: container)
        registerDetailViewModel(container: container)
    }
    
    // MARK: - View containers
    
    private func registerMainViewModel(container: Container) {
        container.register(MainViewModel.self) { r in
            MainViewModel(provider: r.resolve(Provider.self)!)
        }
        container.storyboardInitCompleted(MainViewController.self) { (r, c) in
            c.viewModel = r.resolve(MainViewModel.self)
        }
    }
    
    private func registerDetailViewModel(container: Container) {
        container.register(DetailViewModel.self) { r in
            DetailViewModel(currencyConverter: r.resolve(CurrencyConverterProtocol.self)!)
        }
        container.storyboardInitCompleted(DetailViewController.self) { (r, c) in
            c.viewModel = r.resolve(DetailViewModel.self)
        }
    }
    
    private func registerProvider(container: Container) {
        container.register(Provider.self) { r in
            Provider()
        }
        .inObjectScope(.container)
    }
    
    private func registerCurrencyConverter(container: Container) {
        container.register(CurrencyConverterProtocol.self) { r in
            CurrencyConverter(provider: r.resolve(Provider.self)!)
        }
        .inObjectScope(.container)
    }
    
}
