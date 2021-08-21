//
//  TemplateViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/17/21.
//

import UIKit

class TemplateViewController: UIViewController
{
    //MARK: - Constants and Variables
    var backButtonText: String = "Back"
    
    //MARK: - Objects and IBOutlets
    var navigationBarView = UIView()
    var backButton = UIButton(type: .system)
    var tabBarView = UIView()
    var tabBarLabel = UILabel()
    
    //MARK: - Lifecycle Functions
    init()
    {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, deprecated, message: "No storyboard in use, use other init")
    required init?(coder: NSCoder)
    {
        fatalError("No storyboard in use, use other init")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar()
        setupBackButton()
        setupTabBarView()
        setupTabBarLabel()
    }
    
    override func viewDidLayoutSubviews() //Have access to view's frame here for corner rounding
    {
        backButton.setCornerRounding(percentOfHeightForRadius: 0.33) //Code Smell - Magic Number: 33% was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    //MARK: - Setup and Constraint Functions
    private func setupNavigationBar()
    {
        //Add
        self.view.addSubview(navigationBarView)
        
        //Constrain
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        //Constants here will pull the border off the sides and top giving this view a single underline
        navigationBarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -1).isActive = true
        navigationBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -1).isActive = true
        navigationBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 1).isActive = true
        navigationBarView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 4.65).isActive = true //Code Smell - Magic Number: 4.65 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        navigationBarView.backgroundColor = StyleGuide.lucasPrimaryColor
        navigationBarView.layer.borderColor = StyleGuide.lucasAccentLightColor.cgColor
        navigationBarView.layer.borderWidth = 1 //Code Smell - Magic Number: 1 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    private func setupBackButton()
    {
        //Add
        navigationBarView.addSubview(backButton)

        //Constrain
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        backButton.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor, constant: 8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        backButton.widthAnchor.constraint(equalTo: navigationBarView.widthAnchor, multiplier: StyleGuide.ratio ** 3).isActive = true //Code Smell - Magic Number: 3 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        backButton.heightAnchor.constraint(equalTo: navigationBarView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true //Code Smell - Magic Number: 2 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide

        //Properties
        backButton.backgroundColor = StyleGuide.lucasPrimaryColor
        backButton.setTitle(backButtonText, for: .normal)
        backButton.setTitleColor(StyleGuide.lucasAccentLightColor, for: .normal)
        backButton.layer.borderWidth = 1 //Code Smell - Magic Number: 1 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        backButton.layer.borderColor = StyleGuide.lucasAccentLightColor.cgColor
        
        //Set Button Target
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupTabBarView()
    {
        //Add
        self.view.addSubview(tabBarView)
        
        //Constain
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        //Constants here will pull the border off the sides and top giving this view a single underline
        tabBarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 1).isActive = true
        tabBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -1).isActive = true
        tabBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 1).isActive = true
        tabBarView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 4.65).isActive = true //Code Smell - Magic Number: 4.65 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        tabBarView.backgroundColor = StyleGuide.lucasPrimaryColor
        tabBarView.layer.borderColor = StyleGuide.lucasAccentLightColor.cgColor
        tabBarView.layer.borderWidth = 1 //Code Smell - Magic Number: 1 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    private func setupTabBarLabel()
    {
        //Add
        tabBarView.addSubview(tabBarLabel)

        //Constrain
        tabBarLabel.translatesAutoresizingMaskIntoConstraints = false
        tabBarLabel.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor).isActive = true
        tabBarLabel.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor).isActive = true
        tabBarLabel.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 8).isActive = true
        tabBarLabel.heightAnchor.constraint(equalTo: tabBarView.heightAnchor, multiplier: StyleGuide.ratio ** 1.5).isActive = true //Code Smell - Magic Number: 1.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide

        //Properties
        tabBarLabel.backgroundColor = StyleGuide.lucasPrimaryColor
        tabBarLabel.text = "Tab Bar Under Construction"
        tabBarLabel.textColor = StyleGuide.lucasAccentLightColor
        tabBarLabel.textAlignment = .center
    }
    
    //MARK: - UI Functions and IBActions
    @objc func backButtonTapped()
    {
        self.dismiss(animated: false, completion: nil)
    }
}
