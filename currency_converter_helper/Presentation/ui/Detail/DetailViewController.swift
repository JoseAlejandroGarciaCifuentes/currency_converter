//
//  DetailViewController.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 23/6/22.
//

import UIKit
import RxSwift

class DetailViewController: BaseVC<DetailViewModel>, ActivityIndicatorPresenter {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var transactionsAmount: UILabel!
    @IBOutlet weak var skuTitle: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizedKeys.Details.title
        skuTitle.text = LocalizedKeys.Details.sku + " " + (viewModel.transactions.first?.sku ?? "")
        setupTableView()
        setupViewStateObserver()
        viewModel.viewIsReady()
    }
    
    deinit {
        compositeDisposable.dispose()
    }
    
    // MARK: - UI Logic (ViewModel -> UIViewController)
    
    /**
     This UIViewController subscribes to the detailViewStateObservable to get the current view state and display it
     */
    func setupViewStateObserver() {
        let viewStateDisposable = viewModel.detailViewStateObservable
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [unowned self] viewState in
                    switch (viewState) {
                    case .loading:
                        showActivityIndicator()
                    case .displayInfo(let transactions, let totalSum):
                        displayInfo(transactions: transactions, totalSum: totalSum)
                    case .success:
                        hideActivityIndicator()
                    case .error:
                        hideActivityIndicator()
                    }
                    
                })
        _ = compositeDisposable.insert(viewStateDisposable)
    }
    
    private func setupTableView() {
        // Set data source
        tableView.dataSource = self
    }
    
    func displayInfo(transactions: [TransactionWithEur], totalSum: String) {
        totalAmountLabel.text = totalSum
        transactionsAmount.text = LocalizedKeys.Details.showing + " " + String(describing: transactions.count) + " " + LocalizedKeys.Details.results
        
        hideActivityIndicator()
        tableView.reloadData()
    }

}

// MARK: - Table View Delegate

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transactionsWithEur.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIds.detailCell, for: indexPath)
        viewModel.configure(cell: cell as! DetailCell, forRowAt: indexPath.row)
        return cell
    }
    
}
