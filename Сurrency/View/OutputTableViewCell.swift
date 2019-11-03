//
//  OutputTableViewCell.swift
//  Сurrency
//
//  Created by Алексей Евменьков on 10/10/19.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class OutputTableViewCell: UITableViewCell {
    //MARK: - Properties
    @IBOutlet weak private var usdLabel: UILabel!
    //MARK: - Pass data methods
    public func setupUsd(_ result: Double) {
        usdLabel.text = String(result)
    }
}

