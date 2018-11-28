//
//  SecondViewController.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    static func instance() -> SecondViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        return vc
    }
}
