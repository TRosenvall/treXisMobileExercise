//
//  AccountTableViewCell.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import UIKit

class AccountTableViewCell: UITableViewCell
{
    //MARK: - Constants and Variables
    var isPositiveBalance: Bool?
    var balance: String?
    var modelName: String?
    
    //MARK: - Objects and IBOutlets
    private let borderView = UIView()
    private let modelNameLabel = UILabel()
    private let accountBalanceLabel = UILabel()
    private let selectArrowImageView = UIImageView()
    
    //MARK: - Lifecycle Functions
    //Views have access to parent cell's frame here.
    override func layoutSubviews()
    {
        super.layoutSubviews()
        setupSelfView()
        setupBorderView()
        setupSelectArrowImageView()
        setupModelNameLabel()
        setupAccountBalanceLabel()
    }
    
    //MARK: - Setup and Constraint Functions
    func setupSelfView()
    {
        self.backgroundColor = StyleGuide.lucasPrimaryColor
    }
    
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
    
    func setupSelectArrowImageView()
    {
        //Add
        self.addSubview(selectArrowImageView)
        
        //Constrain
        selectArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        selectArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectArrowImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true //Code Smell - Magic Number: 0.4 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        selectArrowImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -22).isActive = true //Code Smell - Magic Number: 22 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        selectArrowImageView.widthAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true //Code Smell - Magic Number: 2 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        let selectArrowimage = #imageLiteral(resourceName: "Right Arrow")
        selectArrowimage.withRenderingMode(.alwaysTemplate)
        selectArrowImageView.image = selectArrowimage
        selectArrowImageView.tintColor = StyleGuide.lucasAccentLightColor
        selectArrowImageView.contentMode = .scaleAspectFit
    }
    
    func setupModelNameLabel()
    {
        //Add
        self.addSubview(modelNameLabel)
        
        //Constrain
        modelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        modelNameLabel.centerYAnchor.constraint(equalTo: selectArrowImageView.topAnchor).isActive = true
        modelNameLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: frame.width/10).isActive = true //Code Smell - Magic Number: 10 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        modelNameLabel.trailingAnchor.constraint(equalTo: selectArrowImageView.leadingAnchor, constant: -22).isActive = true //Code Smell - Magic Number: 22 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        modelNameLabel.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: 0.25).isActive = true //Code Smell - Magic Number: 0.25 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        guard let accountName = modelName
              else {return}
        modelNameLabel.text = accountName
        modelNameLabel.textColor = StyleGuide.lucasAccentLightColor
        modelNameLabel.font = UIFont.boldSystemFont(ofSize: 22) //Code Smell - Magic Number: 22 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    func setupAccountBalanceLabel()
    {
        //Add
        self.addSubview(accountBalanceLabel)
        
        //Constrain
        accountBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        accountBalanceLabel.topAnchor.constraint(equalTo: modelNameLabel.bottomAnchor).isActive = true
        accountBalanceLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: frame.width/10).isActive = true //Code Smell - Magic Number: 10 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        accountBalanceLabel.trailingAnchor.constraint(equalTo: selectArrowImageView.leadingAnchor, constant: -22).isActive = true //Code Smell - Magic Number: 22 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        accountBalanceLabel.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        guard let accountBalance = balance
              else {return}
        accountBalanceLabel.text = accountBalance
        accountBalanceLabel.textColor = StyleGuide.lucasAccentLightColor
        accountBalanceLabel.font = UIFont.boldSystemFont(ofSize: 33) //Code Smell - Magic Number: 33 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
}
