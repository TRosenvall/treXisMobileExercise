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
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)

    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        //Underline UITextFields
        usernameTextField.setUnderLine(underlineColor: StyleGuide.accentColorOne)
        passwordTextField.setUnderLine(underlineColor: StyleGuide.accentColorOne)
        //Set UIButton cornerRadius (needed because NSLayoutConstraints)
        loginButton.setCornerRounding(percentOfHeightForRadius: 0.33)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: - Setup and Constraint Functions
    func setupViews() {
        setupSelfView()
        setupPasswordTextField()
        setupUsernameTextField()
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

        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.accentColorOne])
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
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

        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.accentColorOne])
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
    }
    
    func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)

        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: StyleGuide.ratio ** 0.5).isActive = true
        loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 6.5).isActive = true

        loginButton.backgroundColor = StyleGuide.accentColorThree
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(StyleGuide.primaryColor, for: .normal)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - UI Functions and IBActions
    @objc func loginButtonTapped() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text
              else {return}
        
        let parameters = [("username", username), ("password", password)]
        
        Networking.shared.login(parameters: parameters) { successfullyLoggedIn in
            AccountController.shared.getAccounts { successfullyRetreivedAccounts in
                if successfullyRetreivedAccounts {
                    //Present Dashboard after receiving account information
                    let dashboardViewController = DashboardViewController()
                    dashboardViewController.modalPresentationStyle = .fullScreen
                    self.present(dashboardViewController, animated: false, completion: nil)
                }
            }
        }
    }
}
