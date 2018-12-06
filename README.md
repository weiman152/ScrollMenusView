# ScrollMenusView
swift4 滑动菜单

 1.滑动菜单View，支持滑动，点击切换，不依赖任何三方，纯手工计算。
 
 2.支持cocoa pods
 
platform :ios, '9.0'
inhibit_all_warnings!

target '你的项目名字' do
    use_frameworks!

pod 'ScrollMenusView'

end

3. 支持左图右文的菜单，初始化使用：
 
 public init(titles: [MenuModel], frame: CGRect, menuHeight: CGFloat = 44) 
 
4. 支持纯文字菜单，初始化使用：

 public init(titles: [String], frame: CGRect, menuHeight: CGFloat = 44) 
 
 5. 支持动态修改某个位置上的菜单文字和图片
 
    /// 更改菜单(change menu at index)
    ///
    /// - Parameters:
    ///   - menu: 要替换的菜单(the menu will be set)
    ///   - index: 要被替换的位置(the index will be set new menu)
    public func change(menu: MenuModel, index: Int)
    
    或者
    
    public func change(title: String, index: Int)
    

使用cocoa pods示例：

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


![Alt Text](https://github.com/weiman152/ScrollMenusView/blob/master/screenShots/1111.png)


不使用cocoa pods，直接导入到项目中，示例：

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
    
    func menuViewNumberOfItems() -> Int {
        return menus.count
    }
    
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
