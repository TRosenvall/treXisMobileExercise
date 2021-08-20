//
//  LoginViewController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/13/21.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Constants and Variables
    var networkRequestProtocol: NetworkRequestProtocol
    var accountController: AccountController
    
    //MARK: - Objects and IBOutlets
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let portTextField = UITextField()
    let loginButton = UIButton(type: .system)

    //MARK: - Lifecycle Functions
    init(networkRequestProtocol: NetworkRequestProtocol)
    {
        self.networkRequestProtocol = networkRequestProtocol
        self.accountController = AccountController(networkRequest: networkRequestProtocol)
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
    }
    
    override func viewDidLayoutSubviews()
    {
        //Underline UITextFields
        usernameTextField.setUnderLine(underlineColor: StyleGuide.lucasAccentLightColor)
        passwordTextField.setUnderLine(underlineColor: StyleGuide.lucasAccentLightColor)
        portTextField.setUnderLine(underlineColor: StyleGuide.lucasAccentLightColor)
        //Set UIButton cornerRadius (needed because NSLayoutConstraints)
        loginButton.setCornerRounding(percentOfHeightForRadius: 0.33)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //Reset username and password text fields
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: - Setup and Constraint Functions
    func setupSelfView()
    {
        //Set View Properties
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
                                                 multiplier: StyleGuide.ratio ** 0.5).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                  multiplier: StyleGuide.ratio ** 6).isActive = true
        
        //Set View Properties
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
                                                 multiplier: StyleGuide.ratio ** 0.5).isActive = true
        usernameTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                  multiplier: StyleGuide.ratio ** 6).isActive = true
        
        //Set View Properties
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
                                             multiplier: StyleGuide.ratio ** 0.5).isActive = true
        portTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                              multiplier: StyleGuide.ratio ** 6).isActive = true
        
        //Set View Properties
        portTextField.backgroundColor = StyleGuide.lucasPrimaryColor
        portTextField.textColor = StyleGuide.lucasAccentLightColor
        portTextField.attributedPlaceholder = NSAttributedString(string: "Server Port Number",
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
        loginButton.topAnchor.constraint(equalTo: portTextField.bottomAnchor, constant: 8).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: StyleGuide.ratio ** 0.5).isActive = true
        loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: StyleGuide.ratio ** 6.5).isActive = true

        //Set View Properties
        loginButton.backgroundColor = StyleGuide.lucasAccentGreenColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(StyleGuide.lucasPrimaryColor, for: .normal)
        
        //Set Button Target
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - UI Functions and IBActions
    @objc func loginButtonTapped()
    {
        
        guard let username = usernameTextField.text,
              let password = passwordTextField.text,
              let portNumber = portTextField.text
              else {return}
        
        networkRequestProtocol.port = portNumber
        
        let parameters = [("username", username), ("password", password)]
        
        networkRequestProtocol.ping
        { successfullyPingedServer in
            if successfullyPingedServer
            {
                //Attempt Login with Parameters
                self.networkRequestProtocol.login(parameters: parameters)
                { successfullyLoggedIn in
                    //If the Login request was successful, try to pull the accounts
                    if successfullyLoggedIn
                    {
                        self.accountController.getAccounts
                        { successfullyRetreivedAccounts in
                            //If accounts were successfully retreived
                            if successfullyRetreivedAccounts
                            {
                                //Present Dashboard after receiving account information
                                let dashboardViewController = DashboardViewController(networkRequestProtocol: self.networkRequestProtocol)
                                dashboardViewController.modalPresentationStyle = .fullScreen
                                self.present(dashboardViewController, animated: false, completion: nil)
                            }
                            else
                            {
                                print("Unable to retrieve account data.")
                            }
                        }
                    }
                    else
                    {
                        print("Incorrect Username or Password.")
                    }
                }
            }
            else
            {
                print("Server Unreachable at Port \(portNumber)")
            }
        }
    }
}
