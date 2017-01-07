//
//  RecommendGameView.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/7.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

fileprivate let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK:- 懒加载
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = kEdgeInsetMargin
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        return collectionView
    }()
    
    // MARK:- 系统回调函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:-  设置UI界面
extension RecommendGameView {
    fileprivate func setupUI() {
        self.addSubview(collectionView)
    }
}

extension RecommendGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
        cell.baseGame = groups?[indexPath.item]
        
        return cell
    }
}
