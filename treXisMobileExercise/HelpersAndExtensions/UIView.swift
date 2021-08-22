//
//  UIButton.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import UIKit

extension UIView
{
    ///This function ended up being less useful than I intended. I mistakenly thought that I'd have access to the view's frame
    ///if I called this, but it must still be called after the view has been entirely initialized and I could have simply set
    ///the corner radius the standard way
    func setCornerRounding(percentOfHeightForRadius: CGFloat?)
    {
        let frameHeight = frame.height
        guard let percent = percentOfHeightForRadius
              else {return}
        layer.cornerRadius = frameHeight * percent
    }
}
