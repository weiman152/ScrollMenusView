//
//  CollectionViewModel.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

protocol CollectionViewModelDelegate: NSObjectProtocol {
    /// 菜单索引改变
    func menuDidChange(index: Int)
    /// 菜单正在滑动
    func menuDidScroll(offset: CGPoint, scrollWidth: CGFloat)
}

protocol CollectionViewModelDataSource: NSObjectProtocol {
    /// 菜单个数
    func menuViewNumberOfItems() -> Int
    /// 菜单的Item
    func menuViewViewForItems(atIndex: Int) -> UIView
}

class CollectionViewModel: NSObject {
    
    weak var delegate: CollectionViewModelDelegate?
    weak var dataSource: CollectionViewModelDataSource?
    
    private var collectionView: UICollectionView?
    private var itemCount = 0
    private var currentIndex = 0
    
    public func set(collectionView: UICollectionView, itemCount: Int) {
        self.collectionView = collectionView
        self.itemCount = itemCount
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView.isPagingEnabled = true
        collectionView.register(CustomCell.self,
                                forCellWithReuseIdentifier: "CustomCell")
    }

}

extension CollectionViewModel {
    
    /// 滑动到某个索引
    public func scrollTo(index: Int) {
        guard let width = collectionView?.frame.size.width else {
            return
        }
        currentIndex = index
        let offX = CGFloat(index) * width
        collectionView?.contentOffset = CGPoint(x: offX, y: 0)
    }
}

extension CollectionViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return itemCount
        return dataSource?.menuViewNumberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath)
        let view = dataSource?.menuViewViewForItems(atIndex: indexPath.row)
        view?.frame = cell.contentView.bounds
        if let view = view {
            cell.addSubview(view)
        }
        return cell
    }
}

extension CollectionViewModel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width,
                      height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CollectionViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset
        delegate?.menuDidScroll(offset: offSet,
                                scrollWidth: scrollView.bounds.size.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let index = offset.x / scrollView.bounds.size.width
        if currentIndex != Int(index) {
            delegate?.menuDidChange(index: Int(index))
            currentIndex = Int(index)
        }
    }
}
