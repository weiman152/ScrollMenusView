//
//  ThirdViewController.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    static func instance() -> ThirdViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        return vc
    }
}
