//
//  TemplateTableViewCell.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import UIKit

class TemplateTableViewCell: UITableViewCell {
    //MARK: - Constants and Variables
    var balance: Float? = nil
    var accountName: String? = nil
    
    //MARK: - Objects and IBOutlets
    let borderView = UIView()
    let accountNameLabel = UILabel()
    let accountBalanceLabel = UILabel()
    let selectArrowImageView = UIImageView()
    
    //MARK: - Setup and Constraint Functions
    func setupBorderView() {
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        
        borderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        guard let balance = balance else {return}
        borderView.layer.borderColor = balance > 0 ? StyleGuide.accentColorThree.cgColor : StyleGuide.accentColorTwo.cgColor
        borderView.backgroundColor = StyleGuide.primaryColor
        borderView.layer.borderWidth = 4
        
        borderView.setCornerRounding(percentOfHeightForRadius: 0.33)
    }
    
    func setupSelectArrowImageView() {
        selectArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectArrowImageView)
        
        selectArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectArrowImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.33).isActive = true
        selectArrowImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -22).isActive = true
        selectArrowImageView.widthAnchor.constraint(equalTo: borderView.widthAnchor, multiplier: 0.1).isActive = true
        
        let selectArrowimage = #imageLiteral(resourceName: "Right Arrow")
        selectArrowimage.withRenderingMode(.alwaysTemplate)
        selectArrowImageView.image = selectArrowimage
        selectArrowImageView.tintColor = StyleGuide.accentColorOne
    }
    
    func setupAccountNameLabel() {
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(accountNameLabel)
        
        accountNameLabel.centerYAnchor.constraint(equalTo: selectArrowImageView.topAnchor).isActive = true
        accountNameLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: frame.width/10).isActive = true
        accountNameLabel.trailingAnchor.constraint(equalTo: selectArrowImageView.leadingAnchor, constant: -22).isActive = true
        accountNameLabel.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: 0.25).isActive = true
        
        guard let accountName = accountName else {return}
        accountNameLabel.text = accountName
        accountNameLabel.textColor = StyleGuide.accentColorOne
        accountNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    func setupAccountBalanceLabel() {
        accountBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(accountBalanceLabel)
        
        accountBalanceLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor).isActive = true
        accountBalanceLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: frame.width/10).isActive = true
        accountBalanceLabel.trailingAnchor.constraint(equalTo: selectArrowImageView.leadingAnchor, constant: -22).isActive = true
        accountBalanceLabel.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8).isActive = true
        
        guard let accountBalance = balance else {return}
        accountBalanceLabel.text = "$\(accountBalance)0"
        accountBalanceLabel.textColor = StyleGuide.accentColorOne
        accountBalanceLabel.font = UIFont.boldSystemFont(ofSize: 33)
    }
}
