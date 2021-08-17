//
//  AccountTableViewCell.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import UIKit

class AccountTableViewCell: TemplateTableViewCell {
    //MARK: - Lifecycle Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorderView()
        setupSelectArrowImageView()
        setupAccountNameLabel()
        setupAccountBalanceLabel()
    }
}
