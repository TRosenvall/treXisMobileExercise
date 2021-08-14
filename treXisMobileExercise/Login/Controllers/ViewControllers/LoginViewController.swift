//
//  LoginViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/13/21.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Constants and Variables
    
    //MARK: - Objects and IBOutlets
    let usernameTextField = UITextField()
    let usernameUnderlineView = UIView()
    let passwordTextField = UITextField()
    let passwordUnderlineView = UIView()
    let loginButton = UIButton(type: .system)

    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup and Constraint Functions
    func setupViews() {
        setupSelfView()
        setupPasswordTextField()
        setupPasswordUnderlineView()
        setupUsernameTextField()
        setupUsernameUnderlineView()
        setupLoginButton()
    }
    
    func setupSelfView() {
        self.view.backgroundColor = StyleGuide.primaryColor
    }
    
    func setupPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordTextField)
        
        passwordTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: StyleGuide.ratio ** 0.5).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 6).isActive = true
        
        passwordTextField.backgroundColor = StyleGuide.primaryColor
        passwordTextField.textColor = StyleGuide.accentColorOne
        
        //Adding Text Padding
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        
        passwordTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: passwordTextField.frame.height))
        passwordTextField.rightViewMode = .always
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.accentColorOne])
    }
    
    func setupPasswordUnderlineView() {
        passwordUnderlineView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordUnderlineView)

        passwordUnderlineView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -8).isActive = true   //TODO: - Find way to adject based on NSLayoutConstraint values
        passwordUnderlineView.bottomAnchor.constraint(equalTo: passwordUnderlineView.topAnchor, constant: 1).isActive = true
        passwordUnderlineView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        passwordUnderlineView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true

        passwordUnderlineView.backgroundColor = StyleGuide.accentColorOne
    }
    
    func setupUsernameTextField() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(usernameTextField)
        
        usernameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: StyleGuide.ratio ** 0.5).isActive = true
        usernameTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 6).isActive = true
        
        usernameTextField.backgroundColor = StyleGuide.primaryColor
        usernameTextField.textColor = StyleGuide.accentColorOne
        
        //Adding Text Padding
        usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: usernameTextField.frame.height))
        usernameTextField.leftViewMode = .always
        
        usernameTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: usernameTextField.frame.height))
        usernameTextField.rightViewMode = .always
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.accentColorOne])
    }
    
    func setupUsernameUnderlineView() {
        usernameUnderlineView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(usernameUnderlineView)

        usernameUnderlineView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: -8).isActive = true   //TODO: - Find way to adject based on NSLayoutConstraint values
        usernameUnderlineView.bottomAnchor.constraint(equalTo: usernameUnderlineView.topAnchor, constant: 1).isActive = true
        usernameUnderlineView.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor).isActive = true
        usernameUnderlineView.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor).isActive = true

        usernameUnderlineView.backgroundColor = StyleGuide.accentColorOne
    }
    
    func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)

        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: StyleGuide.ratio ** 0.5).isActive = true
        loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 6.5).isActive = true

        loginButton.layer.cornerRadius = 8  //TODO: - Find way to adject based on NSLayoutConstraint values
        loginButton.backgroundColor = StyleGuide.accentColorThree
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(StyleGuide.primaryColor, for: .normal)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - UI Functions and IBActions
    @objc func loginButtonTapped() {
        print("loginButtonTapped")
    }
    
    //MARK: - Helper Functions
    
}
