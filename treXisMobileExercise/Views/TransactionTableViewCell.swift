//
//  TransactionTableViewCell.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/17/21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    //MARK: - Constants and Variables
    var isNegative: Bool? = nil
    var balance: String? = nil
    var modelName: String? = nil
    lazy var horizontalLabelConstant = borderView.frame.width != 0 ? (borderView.frame.width * (StyleGuide.ratio ** 5)) : 11
    
    //MARK: - Objects and IBOutlets
    let borderView = UIView()
    let modelNameLabel = UILabel()
    let transactionBalanceLabel = UILabel()
    
    //MARK: - Lifecycle Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorderView()
        setupAccountBalanceLabel()
        setupModelNameLabel()
    }
    
    //MARK: - Setup and Constraint Functions
    func setupBorderView() {
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        
        borderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        guard let isNegative = isNegative else {return}
        borderView.layer.borderColor = !isNegative ? StyleGuide.accentColorThree.cgColor : StyleGuide.accentColorTwo.cgColor
        borderView.backgroundColor = StyleGuide.primaryColor
        borderView.layer.borderWidth = 4
        
        borderView.setCornerRounding(percentOfHeightForRadius: 0.33)
    }
    
    func setupAccountBalanceLabel() {
        transactionBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(transactionBalanceLabel)
        
        transactionBalanceLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        transactionBalanceLabel.widthAnchor.constraint(equalTo: borderView.widthAnchor, multiplier: StyleGuide.ratio ** 3).isActive = true
        transactionBalanceLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -horizontalLabelConstant).isActive = true
        transactionBalanceLabel.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true
        
        guard let transactionBalance = balance else {return}
        transactionBalanceLabel.text = transactionBalance
        transactionBalanceLabel.textColor = StyleGuide.accentColorOne
        transactionBalanceLabel.font = UIFont.systemFont(ofSize: 16)
        transactionBalanceLabel.textAlignment = .right
    }
    
    func setupModelNameLabel() {
        modelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(modelNameLabel)
        
        modelNameLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        modelNameLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: horizontalLabelConstant).isActive = true
        modelNameLabel.trailingAnchor.constraint(equalTo: transactionBalanceLabel.trailingAnchor).isActive = true
        modelNameLabel.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true
        
        guard let accountName = modelName else {return}
        modelNameLabel.text = accountName
        modelNameLabel.textColor = StyleGuide.accentColorOne
        modelNameLabel.font = UIFont.systemFont(ofSize: 16)
    }
}
