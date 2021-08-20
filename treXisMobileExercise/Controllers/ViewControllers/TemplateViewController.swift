//
//  TemplateViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/17/21.
//

import UIKit

class TemplateViewController: UIViewController {

    //MARK: - Constants and Variables
    var backButtonText: String = "Back"
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    //Deprecated
    required init?(coder: NSCoder) {
        fatalError("Dont use this")
    }
    
    //MARK: - Objects and IBOutlets
    var navigationBarView = UIView()
    var backButton = UIButton(type: .system)
    var tabBarView = UIView()
    var tabBarLabel = UILabel()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBackButton()
        setupTabBarView()
        setupTabBarLabel()
    }
    
    override func viewDidLayoutSubviews() {
        backButton.setCornerRounding(percentOfHeightForRadius: 0.33)
    }
    
    //MARK: - Setup and Constraint Functions
    private func setupNavigationBar() {
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationBarView)
        
        //Constants here will pull the border off the sides and top giving this view a single underline
        navigationBarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -1).isActive = true
        navigationBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -1).isActive = true
        navigationBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 1).isActive = true
        navigationBarView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 4.65).isActive = true
        
        navigationBarView.backgroundColor = StyleGuide.lucasPrimaryColor
        navigationBarView.layer.borderColor = StyleGuide.lucasAccentLightColor.cgColor
        navigationBarView.layer.borderWidth = 1
    }
    
    private func setupBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navigationBarView.addSubview(backButton)

        backButton.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -8).isActive = true
        backButton.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor, constant: 8).isActive = true
        backButton.widthAnchor.constraint(equalTo: navigationBarView.widthAnchor, multiplier: StyleGuide.ratio ** 3).isActive = true
        backButton.heightAnchor.constraint(equalTo: navigationBarView.heightAnchor, multiplier: StyleGuide.ratio ** 2).isActive = true

        backButton.backgroundColor = StyleGuide.lucasPrimaryColor
        backButton.setTitle(backButtonText, for: .normal)
        backButton.setTitleColor(StyleGuide.lucasAccentLightColor, for: .normal)
        
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = StyleGuide.lucasAccentLightColor.cgColor
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupTabBarView() {
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tabBarView)
        
        //Constants here will pull the border off the sides and top giving this view a single underline
        tabBarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 1).isActive = true
        tabBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -1).isActive = true
        tabBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 1).isActive = true
        tabBarView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 4.65).isActive = true
        
        tabBarView.backgroundColor = StyleGuide.lucasPrimaryColor
        tabBarView.layer.borderColor = StyleGuide.lucasAccentLightColor.cgColor
        tabBarView.layer.borderWidth = 1
    }
    
    private func setupTabBarLabel() {
        tabBarLabel.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.addSubview(tabBarLabel)

        tabBarLabel.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor).isActive = true
        tabBarLabel.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor).isActive = true
        tabBarLabel.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 8).isActive = true
        tabBarLabel.heightAnchor.constraint(equalTo: tabBarView.heightAnchor, multiplier: StyleGuide.ratio ** 1.5).isActive = true

        tabBarLabel.backgroundColor = StyleGuide.lucasPrimaryColor
        tabBarLabel.text = "Tab Bar Under Construction"
        tabBarLabel.textColor = StyleGuide.lucasAccentLightColor
        tabBarLabel.textAlignment = .center
    }
    
    //MARK: - UI Functions and IBActions
    @objc func backButtonTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK: - Helper Functions
    
}
