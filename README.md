# ScrollMenusView
swift4 滑动菜单

 滑动菜单View，支持滑动，点击切换，不依赖任何三方，纯手工计算。
 
 支持cocoa pods
 
platform :ios, '9.0'
inhibit_all_warnings!

target '你的项目名字' do
    use_frameworks!

pod 'ScrollMenusView'

end

使用：

import UIKit
import ScrollMenusView

class ViewController: UIViewController {
    
    private var menus: [MenuModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let menu1 = MenuModel(title: "菜单一",
                              imageNormal: nil,
                              imageSelected: nil)
        let menu2 = MenuModel(title: "123",
                              imageNormal: nil,
                              imageSelected: nil)
        let menu3 = MenuModel(title: "我是好孩子",
                              imageNormal: nil,
                              imageSelected: nil)
        menus = [menu1, menu2, menu3]
        let frame = CGRect(x: 0,
                           y: 20,
                           width: view.bounds.size.width,
                           height: view.bounds.size.height - 20)
        let menu = ScrollMenus(titles: menus,
                               frame: frame,
                               menuHeight: 44)
        view.addSubview(menu)
        menu.dataSource = self
        menu.delegate = self
    }
}

extension ViewController: ScrollMenusDataSource {
    
    func menuViewNumberOfItems() -> Int {
        return menus.count
    }
    
    func menuViewViewForItems(atIndex: Int) -> UIView {
        return UIView()
    }
}

extension ViewController: ScrollMenusDelegate {
    
    func menuDidChange(currentIndex: Int) {
        print("index = \(currentIndex)")
    }
}


效果图：



