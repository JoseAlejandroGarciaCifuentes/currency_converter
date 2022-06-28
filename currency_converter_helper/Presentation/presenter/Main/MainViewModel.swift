//
//  MainViewModel.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 22/6/22.
//

import Foundation
import Combine
import RxSwift


class MainViewModel: BaseVM {
    
    let provider: Provider
    var cancellable: Set<AnyCancellable> = []
    
    /// Rx PublishSubject responsible for sending the events from the viewModel to the UIViewController - MapVC
    private let mainViewState : PublishSubject<MainViewState> = PublishSubject<MainViewState>()
    
    /// Rx PublishSubject observable to the one the UIViewController - MapVC is attached to get the all the possible states
    var mainViewStateObservable : Observable<MainViewState> {
        return mainViewState
    }
    
    /// The current ViewState of the UIViewController attached - MapVC
    private(set) var currentViewState: MainViewState = .loading
    
    var transactions: [Transaction] = []
    var transactionsToShow: [String] = []
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func viewIsReady() {
        getTransactions()
    }
    
    /**
     Configure notication cells for MainViewController
     */
    func configure(cell: TransactionCell, forRowAt row: Int) {
        let transaction = transactionsToShow[row]
        cell.display(transactionName: transaction)
    }
    
    func moveToDetails(with transactions: [Transaction]) {
        currentViewState = .openDetails(transactions: transactions)
        mainViewState.onNext(currentViewState)
    }
    
    internal func getTransactions() {
        currentViewState = .loading
        mainViewState.onNext(currentViewState)
        
        self.provider.requestTransactions()
            .sink { [weak self] completion in
                guard self != nil else { return }
                switch completion {
                    case .finished: break
                case .failure(let error):
                    print(error.errorDescription)
                }
            } receiveValue: { [weak self] response in
                guard self != nil else { return }
                response.forEach { transaction in
                    self?.transactions.append(Transaction(transaction))
                }
                self?.transactionsToShow = self?.transactions.map { $0.sku }.uniqued() ?? []
                self?.currentViewState = MainViewState.displayTransactions(transactions: self?.transactionsToShow ?? [])
                self?.mainViewState.onNext(self?.currentViewState ?? .loading)
            }
            .store(in: &cancellable)

    }
}
