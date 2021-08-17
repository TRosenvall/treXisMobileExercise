//
//  DashboardViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

class DashboardViewController: UIViewController {
    //MARK: - Objects and IBOutlets
    let accountTableView = UITableView()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup and Constraint Functions
    func setupViews() {
        setupSelfView()
        setupAccountTableView()
    }
    
    func setupSelfView() {
        self.view.backgroundColor = StyleGuide.primaryColor
    }
    
    func setupAccountTableView() {
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        accountTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(accountTableView)
        
        accountTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        accountTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22).isActive = true
        accountTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22).isActive = true
        accountTableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 2/3).isActive = true
        
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
        
        cell.selectionStyle = .none
        cell.backgroundColor = StyleGuide.primaryColor
        cell.accountName = account.name
        cell.balance = account.balance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.numberOfRows(inSection: 0) > 3 {
            return accountTableView.frame.height/3.5
        }
        return accountTableView.frame.height/3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
