//
//  ViewController.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import UIKit
import RxSwift

class MainViewController: BaseVC<MainViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewStateObserver()
        viewModel.viewIsReady()
    }

    deinit {
        compositeDisposable.dispose()
    }
    // MARK: - UI Logic (ViewModel -> UIViewController)
    
    /**
     This UIViewController subscribes to the messagesViewStateObservable to get the current view state and display it
     */
    func setupViewStateObserver() {
        let viewStateDisposable = viewModel.mainViewStateObservable
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] viewState in
                    switch (viewState) {
                    case .loading:
                        print("loading")
                    case .displayTransactions(transactions: let transactions):
                        print("displaying transactions")
                    case .openTransaction:
                        print("open")
                    }
                    
                })
        _ = compositeDisposable.insert(viewStateDisposable)
    }
}

