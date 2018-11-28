//
//  FirstCell.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class FirstCell: UITableViewCell {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    func set(num: Int) {
        numLabel.text = "num = \(num)"
        descLabel.text = num % 2 == 0 ? "Swift" : "OC"
    }
}
