//
//  ViewController.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import UIKit
import RxSwift

class MainViewController: BaseVC<MainViewModel>, ActivityIndicatorPresenter {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var activityIndicator = UIActivityIndicatorView()
    
    /// Array containing the table content
    private var transactionsToShow: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationController()
        setupViewStateObserver()
        viewModel.viewIsReady()
    }

    deinit {
        compositeDisposable.dispose()
    }
    
    // MARK: - UI Logic (ViewModel -> UIViewController)
    
    /**
     This UIViewController subscribes to the mainViewStateObservable to get the current view state and display it
     */
    func setupViewStateObserver() {
        let viewStateDisposable = viewModel.mainViewStateObservable
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [unowned self] viewState in
                    switch (viewState) {
                    case .loading:
                        showActivityIndicator()
                    case .displayTransactions(transactions: let transactions):
                        displayTransactions(transactions: transactions)
                    case .openDetails(let transactions):
                        self.navigationController?.pushViewController(Application.shared.getDetailViewController(transactions: transactions), animated: true)
                    case .onError(error: let error):
                        showAlert(error: error)
                    }
                    
                })
        _ = compositeDisposable.insert(viewStateDisposable)
    }
    
    private func setupTableView() {
        // Set delegate & data source
        tableVIew.delegate = self
        tableVIew.dataSource = self
    }
    
    private func setupNavigationController() {
        self.title = LocalizedKeys.Main.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadView))
    }
    
    /**
     Sets transactions on view
     */
    func displayTransactions(transactions: [String]) {
        self.transactionsToShow = transactions
        hideActivityIndicator()
        tableVIew.reloadData()
    }
    
    @objc
    func reloadView() {
        viewModel.viewIsReady()
    }
    
}

// MARK: - Table View Delegate

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionsToShow.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIds.transactionCell, for: indexPath)
        viewModel.configure(cell: cell as! TransactionCell, forRowAt: indexPath.row)
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    /**
     Tells the delegate that the specified row is now selected
     - Parameter tableView: table-view object informing the delegate about the new row selection
     - Parameter didSelectRowAt: index path locating the new selected row in tableView
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Display transaction in modal view
        let transactionsSelected = viewModel.transactions.filter({ $0.sku == transactionsToShow[indexPath.row] })
        viewModel.moveToDetails(with: transactionsSelected)
    }
    
}

