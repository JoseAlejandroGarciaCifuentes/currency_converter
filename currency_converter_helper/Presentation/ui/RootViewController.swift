//
//  RootViewController.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 22/6/22.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Properties & Initialization
    
    /// The reference to the UIViewController currently being displayed
    private var current: UIViewController
    
    
    /**
     Initialization method for the class. When it is called, the splash screen is set
     */
    init() {
        self.current = Application.shared.getMainNavigationController()
        super.init(nibName: nil, bundle: nil)
    }
    
    /**
     Returns an object initialized from data in a given unarchiver
     - Parameter aDecoder: unarchiver object
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Lifecycle method called when the object is initializing. The currently displayed UIViewController is attached to the window.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    // MARK: - Display screens
    
    /**
     Display the splash-main app flow screen
     */
    func showMainScreen() {
        
        let mainController = Application.shared.getMainNavigationController()
        
        addChild(mainController)
        mainController.view.frame = view.bounds
        view.addSubview(mainController.view)
        mainController.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = mainController
    }
}

