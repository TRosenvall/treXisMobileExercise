//
//  UITextField.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

extension UITextField {
    func setUnderLine(underlineColor: UIColor) {
        if subviews.count >= 2 {
            let xPosition: CGFloat = 0
            let yPosition: CGFloat = (subviews[1].frame.maxY + subviews[0].frame.maxY)/2
            let underlineWidth: CGFloat = (subviews[1].frame.maxX)
            let underlineHeight: CGFloat = 2
        
            let underline = CALayer()
        
            underline.backgroundColor = underlineColor.cgColor
            underline.frame = CGRect(x: xPosition, y: yPosition, width: underlineWidth, height: underlineHeight)

            self.layer.addSublayer(underline)
            self.layer.masksToBounds = true
        }
    }
}
