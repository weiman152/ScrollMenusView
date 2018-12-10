//
//  ViewController.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    private var menus: [MenuModel] = []
    private var scrollMenu: ScrollMenus?
    private var childs: [UIViewController] = [FirstViewController.instance(),
                                              SecondViewController.instance(),
                                              ThirdViewController.instance()]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        childs.forEach { addChildViewController($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        childs.forEach { addChildViewController($0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        
        let menu1 = MenuModel(title: "购买记录",
                              imageNormal: nil,
                              imageSelected: nil)
        let menu2 = MenuModel(title: "680人",
                              imageNormal: #imageLiteral(resourceName: "personNumber_normal"),
                              imageSelected: #imageLiteral(resourceName: "personNumber_selected"))
        let menu3 = MenuModel(title: "商品详情",
                              imageNormal: nil,
                              imageSelected: nil)
        menus = [menu1, menu2, menu3]
        let menu = ScrollMenus(titles: menus,
                               frame: menuView.bounds,
                               menuHeight: 44)
        menu.dataSource = self
        menu.delegate = self
        menu.set(selected: 1)
        menu.lineColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        menu.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        menu.textSeletedColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        menuView.addSubview(menu)
        scrollMenu = menu
    }
    
    /// 更改菜单
    @IBAction func changeMenu(_ sender: Any) {
        let menu = MenuModel(title: "改变的菜单", imageNormal: nil, imageSelected: nil)
        scrollMenu?.change(menu: menu, index: 0)
    }
    
}

extension ViewController: ScrollMenusDataSource {
    
    func menuViewViewForItems(atIndex: Int) -> UIView {
        guard atIndex < menus.count, atIndex < childs.count else {
            return UIView()
        }
        return childs[atIndex].view
    }
}

extension ViewController: ScrollMenusDelegate {
    
    func menuDidChange(currentIndex: Int) {
        print("------------  \(currentIndex)")
        
    }
}

