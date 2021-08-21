//
//  LoginViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/13/21.
//

import UIKit

class LoginViewController: UIViewController
{

    //MARK: - Constants and Variables
    var userControllerProtocol: UserControllerProtocol
    
    //MARK: - Objects and IBOutlets
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let portTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let alertView = AlertView()

    //MARK: - Lifecycle Functions
    init(userControllerProtocol: UserControllerProtocol)
    {
        self.userControllerProtocol = userControllerProtocol
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
        setupSelfView()
        setupPasswordTextField()
        setupUsernameTextField()
        setupPortTextField()
        setupLoginButton()
        setupAlertView()
    }
    
    override func viewDidLayoutSubviews()
    {
        //Underline UITextFields
        usernameTextField.setUnderLine(underlineColor: StyleGuide.lucasAccentLightColor)
        passwordTextField.setUnderLine(underlineColor: StyleGuide.lucasAccentLightColor)
        portTextField.setUnderLine(underlineColor: StyleGuide.lucasAccentLightColor)
        //Set UIButton cornerRadius (needed because NSLayoutConstraints)
        loginButton.setCornerRounding(percentOfHeightForRadius: 0.33) //Code Smell - Magic Number: 33% was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //Reset username and password text fields
        usernameTextField.text = ""
        passwordTextField.text = ""
        alertView.errorString = nil
        alertView.alpha = 0
    }
    
    //MARK: - Setup and Constraint Functions
    func setupSelfView()
    {
        //Properties
        self.view.backgroundColor = StyleGuide.lucasPrimaryColor
    }
    
    func setupPasswordTextField()
    {
        //Add
        self.view.addSubview(passwordTextField)
        
        //Constrain
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor,
                                                 multiplier: StyleGuide.ratio ** 0.5).isActive = true //Code Smell - Magic Number: 0.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        passwordTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                  multiplier: StyleGuide.ratio ** 6).isActive = true //Code Smell - Magic Number: 6 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        passwordTextField.backgroundColor = StyleGuide.lucasPrimaryColor
        passwordTextField.textColor = StyleGuide.lucasAccentLightColor
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.lucasAccentLightColor])
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupUsernameTextField()
    {
        //Add
        self.view.addSubview(usernameTextField)
        
        //Constrain
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor,
                                                 multiplier: StyleGuide.ratio ** 0.5).isActive = true //Code Smell - Magic Number: 0.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        usernameTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                  multiplier: StyleGuide.ratio ** 6).isActive = true //Code Smell - Magic Number: 6 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        usernameTextField.backgroundColor = StyleGuide.lucasPrimaryColor
        usernameTextField.textColor = StyleGuide.lucasAccentLightColor
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.lucasAccentLightColor])
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
    }
    
    func setupPortTextField()
    {
        //Add
        self.view.addSubview(portTextField)
        
        //Constrain
        portTextField.translatesAutoresizingMaskIntoConstraints = false
        portTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        portTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        portTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor,
                                             multiplier: StyleGuide.ratio ** 0.5).isActive = true //Code Smell - Magic Number: 0.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        portTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                              multiplier: StyleGuide.ratio ** 6).isActive = true //Code Smell - Magic Number: 6 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        portTextField.backgroundColor = StyleGuide.lucasPrimaryColor
        portTextField.textColor = StyleGuide.lucasAccentLightColor
        portTextField.attributedPlaceholder = NSAttributedString(string: "Server Port (Default 5555)",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.lucasAccentLightColor])
        portTextField.autocapitalizationType = .none
        portTextField.autocorrectionType = .no
        portTextField.keyboardType = .numberPad
    }
    
    func setupLoginButton()
    {
        //Add
        self.view.addSubview(loginButton)

        //Constrain
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: portTextField.bottomAnchor, constant: 8).isActive = true //Code Smell - Magic Number: 8 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: StyleGuide.ratio ** 0.5).isActive = true //Code Smell - Magic Number: 0.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 6.5).isActive = true //Code Smell - Magic Number: 6.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide

        //Properties
        loginButton.backgroundColor = StyleGuide.lucasAccentGreenColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(StyleGuide.lucasPrimaryColor, for: .normal)
        
        //Set Button Target
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func setupAlertView()
    {
        //Add
        self.view.addSubview(alertView)
        
        //Constrain
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true //Code Smell - Magic Number: 22 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        alertView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        alertView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: StyleGuide.ratio ** 0.5).isActive = true //Code Smell - Magic Number: 0.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        alertView.heightAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: StyleGuide.ratio ** 2.5).isActive = true //Code Smell - Magic Number: 2.5 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        
        //Properties
        alertView.setCornerRounding(percentOfHeightForRadius: 0.33) //Code Smell - Magic Number: 33% was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
    }
    
    //MARK: - UI Functions and IBActions
    @objc func loginButtonTapped()
    {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text,
              let portNumber = portTextField.text
              else {return}
        
        userControllerProtocol.setUsernameAndPassword(username: username, password: password)
        
        let parameters = [("username", username), ("password", password)]
        
        ///The following code is two nested network calls which I'm not quite happy about. Ideally I'd like to keep things on
        ///the root level and independent of each other, but this feels like the most efficient solution currently.
        userControllerProtocol.authenticateAndLogin(port: portNumber, parameters: parameters) { results in
            switch results
            {
            case .success():
                //Attempt to get user accounts from server.
                self.userControllerProtocol.retrieveAccounts
                { results in
                    switch results
                    {
                    case .success():
                        //Present Dashboard after receiving account information
                        let dashboardViewController = DashboardViewController(userControllerProtocol: self.userControllerProtocol)
                        dashboardViewController.modalPresentationStyle = .fullScreen
                        self.present(dashboardViewController, animated: false, completion: nil)
                    case .failure(let networkError):
                        self.sendNetworkErrorToAlertView(networkError: networkError)
                    }
                }
            case.failure(let networkError):
                self.sendNetworkErrorToAlertView(networkError: networkError)
            }
        }
    }
    
    //MARK: - Helper Functions
    func sendNetworkErrorToAlertView(networkError: NetworkError) {
        print(networkError)
        DispatchQueue.main.async {
            self.alertView.errorString = networkError.description
        }
    }
}
