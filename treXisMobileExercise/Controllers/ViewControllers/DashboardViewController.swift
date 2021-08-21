//
//  DashboardViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

class DashboardViewController: TemplateViewController
{
    //MARK: - Constants and Variables
    var userControllerProtocol: UserControllerProtocol
    let accountControllerProtocol: AccountControllerProtocol
    
    //MARK: - Objects and IBOutlets
    let accountTableView = UITableView()
    
    //MARK: - Lifecycle Functions
    init(userControllerProtocol: UserControllerProtocol)
    {
        self.userControllerProtocol = userControllerProtocol
        self.accountControllerProtocol = userControllerProtocol.accountControllerProtocol
        super.init()
    }
    
    @available(*, deprecated, message: "No storyboard in use, use other init")
    required init?(coder: NSCoder)
    {
        fatalError("No storyboard in use, use other init")
    }
    
    override func viewDidLoad()
    {
        backButtonText = "Logout" //Set this property here so it loads with the super.viewDidLoad. Both DashboardViewController and TransactionsViewController are subclassed from TemplateViewController which contains a prototyped navBar and tabBar. The backButton is on the navBar
        super.viewDidLoad()
        setupSelfView()
        setupAccountTableView()
    }
    
    //MARK: - Setup and Constraint Functions
    private func setupSelfView()
    {
        self.view.backgroundColor = StyleGuide.lucasPrimaryColor
    }
    
    private func setupAccountTableView()
    {
        //Set tableview delegate and dataSource
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        //Add
        self.view.addSubview(accountTableView)
        
        //Constrain
        accountTableView.translatesAutoresizingMaskIntoConstraints = false
        accountTableView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor).isActive = true
        accountTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        accountTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        accountTableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor).isActive = true
        
        //Properties
        accountTableView.backgroundColor = StyleGuide.lucasPrimaryColor

        //Set cell reuse identifier
        accountTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "account")
    }
    
    //MARK: - UI Functions and IBActions
    //Reset userController.user when returning to login screen
    @objc override func backButtonTapped()
    {
        userControllerProtocol.user = User()
        super.backButtonTapped()
    }
}

//MARK: - TableView Protocol
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let accounts = userControllerProtocol.user.accounts
              else {return 0}
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Declare cell and what will be its account and properties
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath) as? AccountTableViewCell,
              let accounts = userControllerProtocol.user.accounts
              else {return UITableViewCell()}
        let account = accounts[indexPath.row]
        let isNegativeBalance = AccountController.isNegative(balance: account.balance)
        let balance = AccountController.formatBalance(balance: account.balance)
        
        //Properties
        cell.selectionStyle = .none
        cell.modelName = account.name
        cell.isPositiveBalance = !isNegativeBalance
        cell.balance = balance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90 //Code Smell - Magic Number: 90 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        userControllerProtocol.retrieveAccountTransactions(accountID: "\(indexPath.row + 1)")
        { results in
            switch results
            {
            case .success(()):
                //Present Transactions after receiving account information
                let transactionsViewController = TransactionsViewController(userControllerProtocol: self.userControllerProtocol)
                transactionsViewController.modalPresentationStyle = .fullScreen
                transactionsViewController.accountSelected = indexPath.row
                self.present(transactionsViewController, animated: false, completion: nil)
            case.failure(let networkError):
                print(networkError)
            }
        }
    }
}
