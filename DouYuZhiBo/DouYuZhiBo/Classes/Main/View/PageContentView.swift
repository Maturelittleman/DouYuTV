//
//  PageContentView.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/15.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVCs: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size //   内容尺寸
        layout.minimumLineSpacing = 0 //    行间距
        layout.minimumInteritemSpacing = 0 //   列间距
        layout.scrollDirection = .horizontal //     滚动方向 (横向)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //    显示横向滚动条
        collectionView.isPagingEnabled = true //    翻页
        collectionView.bounces = false //   超出内容范围滚动
        collectionView.dataSource = self //     代理源
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageContentView {
    
    fileprivate func setupUI() {
        
        //  添加到子控制器
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
        }
        
        //  添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- UICollectionView DataSource
extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }

}


