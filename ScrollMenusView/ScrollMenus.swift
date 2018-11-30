//
//  ScrollMenus.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

public protocol ScrollMenusDataSource: NSObjectProtocol {
    /// 菜单个数
    func menuViewNumberOfItems() -> Int
    /// 菜单的Item
    func menuViewViewForItems(atIndex: Int) -> UIView
}

public protocol ScrollMenusDelegate: NSObjectProtocol {
    /// 菜单切换了
    func menuDidChange(currentIndex: Int)
}

public struct MenuModel {
    var title: String             // 标题文字，一定要有
    var imageNormal: UIImage?     // 标题左侧图片，正常状态，可选
    var imageSelected: UIImage?   // 标题左侧图片，选中状态，可选
    
    public init(title: String, imageNormal: UIImage?, imageSelected: UIImage?) {
        self.title = title
        self.imageNormal = imageNormal
        self.imageSelected = imageSelected
    }
}

public class ScrollMenus: UIView {
    
    weak var dataSource: ScrollMenusDataSource?
    weak var delegate: ScrollMenusDelegate?
    var lineColor: UIColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1) {
        didSet {
            line.backgroundColor = lineColor
        }
    }
    /// 菜单文字的颜色
    var textColor: UIColor = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1) {
        didSet {
           menus.textColor = textColor
        }
    }
    /// 选中文字颜色
    var textSeletedColor: UIColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1) {
        didSet {
           menus.textSeletedColor = textSeletedColor
        }
    }
    
    private var menus: MenusView!
    private var line: UIView!
    private var collectionView: UICollectionView!
    private var titles: [MenuModel] = []
    private var menuHeight: CGFloat = 44
    private let collectionViewModel = CollectionViewModel()
    private var lineOriginalX: CGFloat?
    
    public init(titles: [MenuModel], frame: CGRect, menuHeight: CGFloat = 44) {
        self.titles = titles
        self.menuHeight = menuHeight
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setMenus()
        setLine()
        setCollectionView()
    }
    
}

extension ScrollMenus {
    
    /// 设置当前选中的index
    public func set(menuIndex: Int) {
        menuClick(index: menuIndex)
    }
}

extension ScrollMenus {
    
    private func setMenus() {
        let frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: menuHeight)
        menus = MenusView(titles: titles, frame: frame)
        menus.delegate = self
        addSubview(menus)
    }
    
    private func setLine() {
        line = UIView(frame: getLineFrame())
        line.backgroundColor = lineColor
        addSubview(line)
    }
    
    private func setCollectionView() {
        let frame = CGRect(x: 0,
                           y: menuHeight,
                           width: bounds.size.width,
                           height: bounds.size.height - menuHeight)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: frame,
                                          collectionViewLayout: layout)
        addSubview(collectionView)
        collectionViewModel.delegate = self
        collectionViewModel.dataSource = self
        collectionViewModel.set(collectionView: collectionView,
                                itemCount: titles.count)
    }
    
    private func getLineFrame() -> CGRect {
        let selectFrame = menus.selectedFrame()
        var temp: CGFloat = 22
        if selectFrame.size.width > temp {
            temp = 22
        } else {
            temp = selectFrame.size.width
        }
        let x =  selectFrame.origin.x + (selectFrame.size.width - temp) / 2.0
        let frame = CGRect(x: x,
                           y: selectFrame.size.height - 4,
                           width: temp,
                           height: 4)
        return frame
    }
    
    private func updateLineFrame() {
        line.frame = getLineFrame()
        layoutIfNeeded()
    }
}

extension ScrollMenus: CollectionViewModelDelegate {
    
    func menuDidChange(index: Int) {
        menus.setSelect(index: index)
        updateLineFrame()
        delegate?.menuDidChange(currentIndex: index)
    }
    
    func menuDidScroll(offset: CGPoint, scrollWidth: CGFloat) {
        let dis = menus.getScrollDistance()
        let dx = offset.x * dis / scrollWidth
        
        if lineOriginalX == nil {
            lineOriginalX = line.frame.origin.x
        }
        
        let X = (lineOriginalX ?? 0) + dx
        let originalFrame = line.frame
        line.frame = CGRect(x: X,
                            y: originalFrame.origin.y,
                            width: originalFrame.size.width,
                            height: originalFrame.size.height)
        layoutIfNeeded()
    }
}

extension ScrollMenus: CollectionViewModelDataSource {
    
    func menuViewNumberOfItems() -> Int {
        return dataSource?.menuViewNumberOfItems() ?? 0
    }
    
    func menuViewViewForItems(atIndex: Int) -> UIView {
        return dataSource?.menuViewViewForItems(atIndex: atIndex) ?? UIView()
    }
}

extension ScrollMenus: MenusViewDelegate {
    
    func menuClick(index: Int) {
        updateLineFrame()
        menus.setSelect(index: index)
        collectionViewModel.scrollTo(index: index)
        delegate?.menuDidChange(currentIndex: index)
    }
}
