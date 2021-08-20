//
//  TransactionsViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import UIKit

class TransactionsViewController: TemplateViewController {
    //MARK: - Objects and IBOutlets
    let transactionsTableView = UITableView()
    var accountSelected: Int? = nil
    let totalLabel = UILabel()
    var networkRequestProtocol: NetworkRequestProtocol
    
    init(networkRequestProtocol: NetworkRequestProtocol) {
        self.networkRequestProtocol = networkRequestProtocol
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use this")
    }
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelfView()
        setupTransactionsTableView()
        setupTotalLabel()
    }
    
    //MARK: - Setup and Constraint Functions
    private func setupSelfView() {
        self.view.backgroundColor = StyleGuide.lucasPrimaryColor
    }
    
    private func setupTransactionsTableView() {
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        transactionsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(transactionsTableView)
        
        transactionsTableView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor).isActive = true
        transactionsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        transactionsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        transactionsTableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor).isActive = true
        
        transactionsTableView.backgroundColor = StyleGuide.lucasPrimaryColor
        
        transactionsTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "transaction")
        transactionsTableView.showsVerticalScrollIndicator = false
    }
    
    private func setupTotalLabel() {
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationBarView.addSubview(totalLabel)
        
        totalLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        totalLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        totalLabel.bottomAnchor.constraint(equalTo: backButton.bottomAnchor).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        
        guard let accountSelected = accountSelected else {return}
        let account = AccountController.shared.accounts[accountSelected]
        let accountBalance = AccountController.shared.formatBalance(balance: account.balance)
        totalLabel.text = "Account Total: " + accountBalance
        
        totalLabel.textColor = StyleGuide.lucasAccentLightColor
        totalLabel.textAlignment = .right
    }
}

//MARK: - TableView Protocol
extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionController.shared.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath) as? TransactionTableViewCell else {return UITableViewCell()}
        let transaction = TransactionController.shared.transactions[indexPath.row]
        let isNegativeBalance = TransactionController.shared.isNegative(balance: transaction.balance)
        let balance = TransactionController.shared.formatBalance(balance: transaction.balance)
        
        cell.selectionStyle = .none
        cell.backgroundColor = StyleGuide.lucasPrimaryColor
        cell.modelName = transaction.title
        cell.isPositiveBalance = !isNegativeBalance
        cell.balance = balance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
