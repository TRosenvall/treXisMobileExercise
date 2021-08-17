//
//  TemplateTableViewCell.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    //MARK: - Constants and Variables
    var isNegative: Bool? = nil
    var balance: String? = nil
    var modelName: String? = nil
    
    //MARK: - Objects and IBOutlets
    let borderView = UIView()
    let modelNameLabel = UILabel()
    let accountBalanceLabel = UILabel()
    let selectArrowImageView = UIImageView()
    
    //MARK: - Lifecycle Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorderView()
        setupSelectArrowImageView()
        setupModelNameLabel()
        setupAccountBalanceLabel()
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
    
    func setupSelectArrowImageView() {
        selectArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectArrowImageView)
        
        selectArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectArrowImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        selectArrowImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -22).isActive = true
        selectArrowImageView.widthAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true
        
        let selectArrowimage = #imageLiteral(resourceName: "Right Arrow")
        selectArrowimage.withRenderingMode(.alwaysTemplate)
        selectArrowImageView.image = selectArrowimage
        selectArrowImageView.tintColor = StyleGuide.accentColorOne
        selectArrowImageView.contentMode = .scaleAspectFit
    }
    
    func setupModelNameLabel() {
        modelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(modelNameLabel)
        
        modelNameLabel.centerYAnchor.constraint(equalTo: selectArrowImageView.topAnchor).isActive = true
        modelNameLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: frame.width/10).isActive = true
        modelNameLabel.trailingAnchor.constraint(equalTo: selectArrowImageView.leadingAnchor, constant: -22).isActive = true
        modelNameLabel.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: 0.25).isActive = true
        
        guard let accountName = modelName else {return}
        modelNameLabel.text = accountName
        modelNameLabel.textColor = StyleGuide.accentColorOne
        modelNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    func setupAccountBalanceLabel() {
        accountBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(accountBalanceLabel)
        
        accountBalanceLabel.topAnchor.constraint(equalTo: modelNameLabel.bottomAnchor).isActive = true
        accountBalanceLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: frame.width/10).isActive = true
        accountBalanceLabel.trailingAnchor.constraint(equalTo: selectArrowImageView.leadingAnchor, constant: -22).isActive = true
        accountBalanceLabel.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8).isActive = true
        
        guard let accountBalance = balance else {return}
        accountBalanceLabel.text = accountBalance
        accountBalanceLabel.textColor = StyleGuide.accentColorOne
        accountBalanceLabel.font = UIFont.boldSystemFont(ofSize: 33)
    }
}
