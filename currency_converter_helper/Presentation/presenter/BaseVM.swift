//
//  BaseVM.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 22/6/22.
//

import Foundation
import RxSwift

class BaseVM: NSObject {
    var activityIndicator = UIActivityIndicatorView()
    
    /// RxSwift
    private(set) var compositeDisposable = CompositeDisposable()
    
    func viewWillDisappear() {
        compositeDisposable.dispose()
    }
    
    deinit {
        compositeDisposable.dispose()
    }
}
