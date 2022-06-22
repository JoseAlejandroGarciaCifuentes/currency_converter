//
//  BaseVC.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 22/6/22.
//

import Foundation
import UIKit
import RxSwift

class BaseVC<T: BaseVM>: UIViewController {
    
    var viewModel: T!
    
    /// RxSwift
    private(set) var compositeDisposable = CompositeDisposable()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        // View will be removed from the menu
        if (parent == nil) {
            viewModel.viewWillDisappear()
        }
        super.willMove(toParent: parent)
    }
    
    deinit {
        compositeDisposable.dispose()
    }
}
