//
//  UIButton.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

extension UIButton {
    func setCornerRounding(percentOfHeightForRadius: CGFloat?) {
        if let buttonLabel = subviews[0] as? UILabel, buttonLabel.text != "" {
            let frameHeight = frame.height
            guard let percent = percentOfHeightForRadius else {return}
            layer.cornerRadius = frameHeight * percent
        }
    }
}
