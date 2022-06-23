//
//  ViewController.swift
//  currency_converter_helper
//
//  Created by Alejandro Garcia on 21/6/22.
//

import UIKit
import RxSwift

class MainViewController: BaseVC<MainViewModel>, ActivityIndicatorPresenter {
    
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var tableVIew: UITableView!
    
    /// Array containing the table content
    private var transactions: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
                        print("loading")
                    case .displayTransactions(transactions: let transactions):
                        let newTrans = transactions.unique { $0.sku == $1.sku }
                        displayTransactions(newTrans)
                        print("displaying transactions")
                    case .openDetails:
                        print("open")
                        self.performSegue(withIdentifier: "toDetail", sender: nil)
                    }
                    
                })
        _ = compositeDisposable.insert(viewStateDisposable)
    }
    
    private func setupTableView() {
        // Set delegate & data source
        tableVIew.delegate = self
        tableVIew.dataSource = self
    }
    
    func displayTransactions(_ transactions: [Transaction]) {
        self.transactions = transactions
        hideActivityIndicator()
        tableVIew.reloadData()
    }
    
}

// MARK: - Table View Delegate

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIds.transactionCell, for: indexPath)
        viewModel.configure(cell: cell as! TransactionCell, forRowAt: indexPath.section)
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
        viewModel.moveToDetails(with: transactions[indexPath.row])
    }
}

