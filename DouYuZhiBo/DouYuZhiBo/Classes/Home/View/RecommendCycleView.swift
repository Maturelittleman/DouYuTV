//
//  RecommendCycleView.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/4.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

fileprivate let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    var cycleModels: [CycleModel]? {
        didSet {
            //  获取到数据刷新collectionview
            self.collectionView.reloadData()
            
            //设置 pageControl 个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //默认滚动到中间的某数,以让无限滚动前也有数据
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    fileprivate var cycleTimer : Timer?
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true //    翻页
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0   //  点的个数
        pageControl.currentPage = 0     //  初始选中点
        pageControl.currentPageIndicatorTintColor = UIColor.orange  //  选中点颜色
        pageControl.pageIndicatorTintColor = UIColor.darkGray       //  未选中点颜色
        
        return pageControl
    }()

    override init (frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI界面
extension RecommendCycleView {
    
    fileprivate func setupUI() {
        
        self.addSubview(collectionView)
        
        self.addSubview(pageControl)

        pageControl.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(5)
        }
    }
}


// MARK:- CollectionView数据源
extension RecommendCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionViewCycleCell
        
        cell.cycleModel = self.cycleModels![indexPath.item % self.cycleModels!.count]
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}

// MARK:- CollectionView代理
extension RecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //开始拖动 停止定时器
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //停止拖动 开启定时器
        addCycleTimer()
    }
}

// MARK:- 定时器操作
extension RecommendCycleView {
    
    //添加定时器
    fileprivate func addCycleTimer() {
        
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
    }
    //取消定时器
    fileprivate func removeCycleTimer() {
        
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    //  滚动方法
    @objc fileprivate func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}

