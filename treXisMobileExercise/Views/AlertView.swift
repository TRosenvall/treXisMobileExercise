//
//  AlertView.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/20/21.
//

import UIKit

class AlertView: UIView
{
    //MARK: - Constants and Variables
    var errorString: String? = String()
    {
        didSet {
            //If a new error is passed into the alertView, run the flashAlert() function to display it.
            flashAlert(errorString: errorString)
        }
    }
    
    //MARK: - Objects and IBOutlets
    private let errorLabel = UILabel()
    private let okayButton = UIButton(type: .system)
    
    //MARK: - Lifecycle Functions
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        //Initialize the alertView but keep it hidden. It will get displayed should an error be thrown.
        self.alpha = 0
    }

    @available(*, deprecated, message: "No storyboard in use, use other init")
    required init?(coder: NSCoder)
    {
        fatalError("No storyboard in use, use other init")
    }
    
    //Views have access to parent cell's frame here.
    override func layoutSubviews()
    {
        super.layoutSubviews()
        setupSelfView()
        setupErrorLabel()
    }
    
    //MARK: - Setup and Constraint Functions
    func setupSelfView()
    {
        //Properties
        self.backgroundColor = StyleGuide.lucasPrimaryColor
        self.layer.borderWidth = 1 //Code Smell - Magic Number: 1 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        self.layer.borderColor = StyleGuide.lucasAccentRedColor.cgColor
    }
    
    func setupErrorLabel()
    {
        //Add
        self.addSubview(errorLabel)
        
        //Constrain
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        //Code Smell - Magic Number: The 11s below were arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        errorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 11).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11).isActive = true
        
        //Properties
        errorLabel.textColor = StyleGuide.lucasAccentRedColor
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.boldSystemFont(ofSize: 22) //Code Smell - Magic Number: 22 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        errorLabel.numberOfLines = 0
    }
    
    //MARK: - Helper Functions
    func flashAlert(errorString: String?)
    {
        //Get the unwrapped errorString
        guard let errorString = errorString
              else {return}
        //If self.alpha == 1, then an error has already been displayed and the alertView is currently visible.
        if self.alpha == 1
        {
            //Hide the error label
            hideAnimation
            { finishedAnimating in
                if finishedAnimating
                {
                    //Update the error label and then display it again
                    self.errorLabel.text = errorString
                    self.displayAnimation(completion: nil)
                }
            }
        }
        //If self.alpha == 0, then no error has been shown, need to update the errorLabel and show the alertView
        else
        {
            self.errorLabel.text = errorString
            self.displayAnimation(completion: nil)
        }
    }
    
    //An animation to show the alertView and errorLabel, used within the flashAlert() function.
    func displayAnimation(completion: ((Bool) -> Void)?)
    {
        UIView.animate(withDuration: 0.125, animations: { //Code Smell - Magic Number: 0.125 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
            self.alpha = 1
            self.errorLabel.alpha = 1
        }, completion: completion)
    }
    
    //An animation to hide the errorLabel so that it can be updated offscreen, used within the flashAlert() function.
    func hideAnimation(completion: ((Bool) -> Void)?)
    {
        UIView.animate(withDuration: 0.125, animations: //Code Smell - Magic Number: 0.125 was arbitrarily chosen, it looked nice, it should have come as a definition from the style guide
        {
            self.errorLabel.alpha = 0
        }, completion: completion)
    }
}
