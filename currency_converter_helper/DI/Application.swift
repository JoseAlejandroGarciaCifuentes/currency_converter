//
//  Application.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import Foundation
import Swinject
import SwinjectStoryboard

final class Application {
    
    static let shared = Application()
 
    // MARK: - Properties & Initialization
    var assembler: Assembler!
    
    init() {
        assembler = Assembler([
            ApplicationAssembly(),
            TargetAssembly()])
    }
    
    func startApp(mainWindow: UIWindow) {
        
        mainWindow.rootViewController = RootViewController()
        mainWindow.makeKeyAndVisible()
    }
    
    // MARK: - Clean Architecture Logic
    
    class ApplicationAssembly: Assembly {
        
        // TODO: Add something here?
        func assemble(container: Container) {
        }
    }
    
    /**
     Connect the layers of the app (VIPER) for the menu navigation
     - Returns: The menu navigation controller
     */
    func getMainNavigationController() -> UINavigationController {
        let startStoryboard = SwinjectStoryboard.create(name: Constants.Storyboard.main, bundle: nil, container: assembler.resolver)
        return startStoryboard.instantiateInitialViewController() as! UINavigationController
    }
    
    func getDetailViewController(transactions: [Transaction]) -> DetailViewController {
        let mainStoryboard = SwinjectStoryboard.create(name: Constants.Storyboard.main, bundle: nil, container: assembler.resolver)
        let detailVC = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewController.detailVC) as! DetailViewController
        detailVC.viewModel.transactions = transactions
        return detailVC
    }

}
