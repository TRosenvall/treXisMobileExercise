//
//  DashboardViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

class DashboardViewController: TemplateViewController {
    //MARK: - Objects and IBOutlets
    let accountTableView = UITableView()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        backButtonText = "Logout" //Set this property here so it loads with the super.viewDidLoad
        super.viewDidLoad()
        setupSelfView()
        setupAccountTableView()
    }
    
    //MARK: - Setup and Constraint Functions
    private func setupSelfView() {
        self.view.backgroundColor = StyleGuide.primaryColor
    }
    
    private func setupAccountTableView() {
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        accountTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(accountTableView)
        
        accountTableView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor).isActive = true
        accountTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        accountTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        accountTableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor).isActive = true
        
        accountTableView.backgroundColor = StyleGuide.primaryColor
        
        accountTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "account")
    }
}

//MARK: - TableView Protocol
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountController.shared.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath) as? AccountTableViewCell else {return UITableViewCell()}
        let account = AccountController.shared.accounts[indexPath.row]
        let isNegative = AccountController.shared.isNegative(balance: account.balance)
        let balance = AccountController.shared.formatBalance(balance: account.balance)
        
        cell.selectionStyle = .none
        cell.backgroundColor = StyleGuide.primaryColor
        cell.modelName = account.name
        cell.isNegative = isNegative
        cell.balance = balance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TransactionController.shared.getTransactions(accountID: "\(indexPath.row + 1)") { successfullyRetrievedTRansactions in
            if successfullyRetrievedTRansactions {
                //Present Transactions after receiving account information
                let transactionsViewController = TransactionsViewController()
                transactionsViewController.modalPresentationStyle = .fullScreen
                transactionsViewController.accountSelected = indexPath.row
                self.present(transactionsViewController, animated: false, completion: nil)
            }
        }
    }
}
