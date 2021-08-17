//
//  UIButton.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

extension UIView {
    func setCornerRounding(percentOfHeightForRadius: CGFloat?) {
        let frameHeight = frame.height
        guard let percent = percentOfHeightForRadius else {return}
        layer.cornerRadius = frameHeight * percent
    }
}
