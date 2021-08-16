//
//  DashboardViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK: - Constants and Variables
    
    //MARK: - Objects and IBOutlets
    let accountTableView = UITableView()
    
    //MARK: - Constraints
    
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
        self.view.backgroundColor = .red
    }
    
    func setupAccountTableView() {
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        accountTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(accountTableView)
        
        accountTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        accountTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22).isActive = true
        accountTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22).isActive = true
        accountTableView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: "account")
    }
    
    //MARK: - UI Functions and IBActions
    
    //MARK: - Helper Functions
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountController.shared.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath)
        let account = AccountController.shared.accounts[indexPath.row]
        
        cell.textLabel?.text = account.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.numberOfRows(inSection: 0) > 3 {
            return accountTableView.frame.height/3.5
        }
        return accountTableView.frame.height/3
    }
}
