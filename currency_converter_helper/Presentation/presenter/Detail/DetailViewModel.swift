//
//  DetailViewModel.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 23/6/22.
//

import Foundation
import Combine
import RxSwift

class DetailViewModel: BaseVM {

    var transactions: [Transaction] = []
    var transactionsWithEur: [TransactionWithEur] = []
    
    var currencyConverter: CurrencyConverterProtocol
    //let provider: Provider
    var cancellable: Set<AnyCancellable> = []
    
    /// Rx PublishSubject responsible for sending the events from the viewModel to the UIViewController - DetailViewController
    private let detailViewState : PublishSubject<DetailViewState> = PublishSubject<DetailViewState>()
    
    /// Rx PublishSubject observable to the one the UIViewController - DetailViewController is attached to get the all the possible states
    var detailViewStateObservable : Observable<DetailViewState> {
        return detailViewState
    }
    
    /// The current ViewState of the UIViewController attached - MapVC
    private(set) var currentViewState: DetailViewState = .loading
    
    init(currencyConverter: CurrencyConverterProtocol) {
        self.currencyConverter = currencyConverter
    }
    
    func viewIsReady() {
        self.currencyConverter.delegate = self
        currencyConverter.getRates()
    }
    
    /**
     Configure notication cells for MainViewController
     */
    func configure(cell: DetailCell, forRowAt row: Int) {
        let transaction = transactionsWithEur[row]
        cell.display(transaction: transaction, position: row + 1)
    }
    
}

extension DetailViewModel: CurrencyConverterDelegate {
    func onSuccess() {
        currentViewState = .success
        detailViewState.onNext(currentViewState)
        
        var amounts: [Double] = []
        transactions.forEach { transaction in
            let amount = currencyConverter.getAmountInEur(currency: Currencies(rawValue: transaction.currency) ?? .EUR, amount: transaction.amount.toDouble() ?? Double())
            amounts.append(amount)
            transactionsWithEur.append(TransactionWithEur(transaction: transaction, amountInEur: String(describing: amount).roundToHalfEven()))
        }
        
        let totalAmountEur = String(describing: amounts.reduce(0, +)).roundToHalfEven() + " " + Constants.Symbols.eur
        currentViewState = .displayInfo(transactions: transactionsWithEur, totalSum: totalAmountEur)
        detailViewState.onNext(currentViewState)
    }
    
    func onLoading() {
        currentViewState = .loading
        detailViewState.onNext(currentViewState)
    }
    
    func onError(_ error: String) {
        currentViewState = .onError(error: error)
        detailViewState.onNext(currentViewState)
    }
    
    
}
