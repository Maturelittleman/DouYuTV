//
//  PageContentView.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/15.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

protocol PageContentViewDelegate: class {
    func pageCotentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
    
}

class PageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVCs: [UIViewController]    //  保存子控制器的数组
    fileprivate weak var parentViewController: UIViewController?    //  当前显示的控制器
    fileprivate var startOffsetX: CGFloat = 0   //  滑动开始的点
    fileprivate var isForbidScrollDelegate: Bool = false    //  记录当前点击事件
    weak var delegate : PageContentViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)! //   内容尺寸
        layout.minimumLineSpacing = 0 //    行间距
        layout.minimumInteritemSpacing = 0 //   列间距
        layout.scrollDirection = .horizontal //     滚动方向 (横向)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //    显示横向滚动条
        collectionView.isPagingEnabled = true //    翻页
        collectionView.bounces = false //   超出内容范围滚动
        collectionView.dataSource = self //     数据源
        collectionView.delegate = self //   代理源
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

// MARK:- UICollection Delegate
extension PageContentView: UICollectionViewDelegate {
    //  获取到当前开始滑动的点
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //  记录为滑动状态
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    //  计算正在滑动时的偏移量
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //  如果是点击标题不执行以下方法
        if isForbidScrollDelegate { return }
        
        //  定义要获取的数据
        var progress : CGFloat = 0  //   偏移量
        var sourceIndex: Int = 0   //   当前的位置
        var targetIndex: Int = 0   //   滑动后的位置
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        //  判断是左划还是右划
        if currentOffsetX > startOffsetX {     //  左划
            //  计算偏移量
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //  计算当前位置
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //  计算滑动后位置
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            //  完全划过去后
//            if currentOffsetX - startOffsetX == scrollViewW {
//                progress = 1
//                targetIndex = sourceIndex
//            }
        }else {     //  右划
            progress = 1 - (currentOffsetX / scrollViewW  - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int (currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        delegate?.pageCotentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    
    //  设置点击标题栏跳转相应控制器
    func setCurrentIndex(currentIndex: Int) {
        //  记录点击标题状态
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
