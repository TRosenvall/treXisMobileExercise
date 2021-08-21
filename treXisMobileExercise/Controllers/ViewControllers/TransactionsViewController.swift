//
//  TransactionsViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import UIKit

class TransactionsViewController: TemplateViewController
{
    //MARK: - Constants and Variables
    var userControllerProtocol: UserControllerProtocol
    
    //MARK: - Objects and IBOutlets
    let transactionsTableView = UITableView()
    var accountSelected: Int?
    let totalLabel = UILabel()
    
    //MARK: - Lifecycle Functions
    init(userControllerProtocol: UserControllerProtocol)
    {
        self.userControllerProtocol = userControllerProtocol
        super.init()
    }
    
    @available(*, deprecated, message: "No storyboard in use, use other init")
    required init?(coder: NSCoder)
    {
        fatalError("No storyboard in use, use other init")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSelfView()
        setupTotalLabel()
        setupTransactionsTableView()
    }
    
    //MARK: - Setup and Constraint Functions
    private func setupSelfView()
    {
        self.view.backgroundColor = StyleGuide.lucasPrimaryColor
    }
    
    private func setupTransactionsTableView()
    {
        //Set tableview delegate and dataSource
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        //Add
        self.view.addSubview(transactionsTableView)
        
        //Constrain
        transactionsTableView.translatesAutoresizingMaskIntoConstraints = false
        transactionsTableView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor).isActive = true
        transactionsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        transactionsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        transactionsTableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor).isActive = true
        
        //Properties
        transactionsTableView.backgroundColor = StyleGuide.lucasPrimaryColor
        transactionsTableView.showsVerticalScrollIndicator = false
        
        //Set cell reuse identifier
        transactionsTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "transaction")
    }
    
    private func setupTotalLabel()
    {
        //Add
        navigationBarView.addSubview(totalLabel)
        
        //Constrain
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        totalLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        totalLabel.bottomAnchor.constraint(equalTo: backButton.bottomAnchor).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        
        //Properties
        guard let accountSelected = accountSelected,
              let accounts = userControllerProtocol.user.accounts
              else {return}
        let account = accounts[accountSelected]
        let accountBalance = AccountController.formatBalance(balance: account.balance)
        totalLabel.text = "Account Total: " + accountBalance
        totalLabel.textColor = StyleGuide.lucasAccentLightColor
        totalLabel.textAlignment = .right
    }
}

//MARK: - TableView Protocol
extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let transactions = userControllerProtocol.user.transactions
              else {return 0}
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Declare cell and what will be its account and properties
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath) as? TransactionTableViewCell,
              let transactions = userControllerProtocol.user.transactions
              else {return UITableViewCell()}
        
        let transaction = transactions[indexPath.row]
        let isNegativeBalance = TransactionController.isNegative(balance: transaction.balance)
        let balance = TransactionController.formatBalance(balance: transaction.balance)
        
        //Properties
        cell.selectionStyle = .none
        cell.backgroundColor = StyleGuide.lucasPrimaryColor
        cell.modelName = transaction.title
        cell.isPositiveBalance = !isNegativeBalance
        cell.balance = balance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70 //Code Smell - Magic Number: 70 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
}
