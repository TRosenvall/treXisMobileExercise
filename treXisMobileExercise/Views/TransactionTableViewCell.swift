//
//  TransactionTableViewCell.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/17/21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell
{
    //MARK: - Constants and Variables
    var isPositiveBalance: Bool?
    var balance: String?
    var modelName: String?
    
    //MARK: - Objects and IBOutlets
    private let borderView = UIView()
    private let modelNameLabel = UILabel()
    private let transactionBalanceLabel = UILabel()
    
    //MARK: - Lifecycle Functions
    //Views have access to parent cell's frame here.
    override func layoutSubviews()
    {
        super.layoutSubviews()
        setupBorderView()
        setupAccountBalanceLabel()
        setupModelNameLabel()
    }
    
    //MARK: - Setup and Constraint Functions
    func setupBorderView()
    {
        //Add
        self.addSubview(borderView)
        
        //Constrain
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        //Properties
        guard let isPositiveBalance = isPositiveBalance
              else {return}
        borderView.layer.borderColor = isPositiveBalance ? StyleGuide.lucasAccentGreenColor.cgColor : StyleGuide.lucasAccentRedColor.cgColor
        borderView.backgroundColor = StyleGuide.lucasPrimaryColor
        borderView.layer.borderWidth = 2 //Code Smell - Magic Number: 2 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        borderView.setCornerRounding(percentOfHeightForRadius: 0.33) //Code Smell - Magic Number: 33% was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    func setupAccountBalanceLabel()
    {
        //Add
        self.addSubview(transactionBalanceLabel)
        
        //Constrain
        transactionBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionBalanceLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        transactionBalanceLabel.widthAnchor.constraint(equalTo: borderView.widthAnchor, multiplier: StyleGuide.ratio ** 3).isActive = true //Code Smell - Magic Number: 3 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        transactionBalanceLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -11).isActive = true //Code Smell - Magic Number: -11 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        transactionBalanceLabel.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true //Code Smell - Magic Number: 2 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        guard let transactionBalance = balance
              else {return}
        transactionBalanceLabel.text = transactionBalance
        transactionBalanceLabel.textColor = StyleGuide.lucasAccentLightColor
        transactionBalanceLabel.font = UIFont.systemFont(ofSize: 16) //Code Smell - Magic Number: 16 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        transactionBalanceLabel.textAlignment = .right
    }
    
    func setupModelNameLabel()
    {
        //Add
        self.addSubview(modelNameLabel)
        
        //Constrain
        modelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        modelNameLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        modelNameLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 11).isActive = true //Code Smell - Magic Number: 11 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        modelNameLabel.trailingAnchor.constraint(equalTo: transactionBalanceLabel.trailingAnchor).isActive = true
        modelNameLabel.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true //Code Smell - Magic Number: 2 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        guard let accountName = modelName
              else {return}
        modelNameLabel.text = accountName
        modelNameLabel.textColor = StyleGuide.lucasAccentLightColor
        modelNameLabel.font = UIFont.systemFont(ofSize: 16) //Code Smell - Magic Number: 16 was arbitrarily chosen, it looked nice, but it should have come from the style guide
    }
}
