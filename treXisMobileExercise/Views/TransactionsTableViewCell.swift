//
//  TransactionsTableViewCell.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import UIKit

class TransactionsTableViewCell: TemplateTableViewCell {
    //MARK: - Lifecycle Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorderView()
        setupAccountNameLabel()
        setupAccountBalanceLabel()
    }
}
