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
        registerMainViewModel(container: container)
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
    
    private func registerProvider(container: Container) {
        container.register(Provider.self) { r in
            Provider()
        }
        .inObjectScope(.container)
    }
    
}
