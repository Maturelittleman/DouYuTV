//
//  RecommendViewController.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/31.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

fileprivate let kItemMargin: CGFloat = 10  //  item间距
fileprivate let kHeaderViewH: CGFloat = 50  //  头部view的高度

fileprivate let kNormalItemW = (kScreenW - 3*kItemMargin) / 2  //  item宽度

fileprivate let kNormalItemH = kNormalItemW * 3 / 4  //  普通Item高度
fileprivate let kPrettyItemH = kNormalItemW * 4 / 3  //  颜值Item高度

fileprivate let kNormalCellID = "kNormalCellID"     //  普通CellID
fileprivate let kPrettyFaceCellID = "kPrettyFaceCellID"     //  颜值CellID
fileprivate let kHeaderViewID = "kHeaderViewID"     //  组头的CellID

class RecommendViewController: UIViewController {
    
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        
        //  创建布局
        let layout = UICollectionViewFlowLayout()   //  流水布局
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH) //  设置cell高度
        layout.minimumLineSpacing = 0   //  高度间距
        layout.minimumInteritemSpacing = kItemMargin    // 宽度间距
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)  //  设置内边距
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //  创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth] //  宽高相对于父控件自适应

        collectionView.register(CollectionNormalCell.self, forCellWithReuseIdentifier: kNormalCellID)   //  自定义CollectionViewCell
        collectionView.register(CollectionPrettyFaceCell.self, forCellWithReuseIdentifier: kPrettyFaceCellID)
        
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)    //  自定义Cell头部
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}

// MARK:- 设置UI
extension RecommendViewController {
    fileprivate func setupUI() {
        self.view.addSubview(collectionView)
    }
}


// MARK:- 网络请求
extension RecommendViewController {
    fileprivate func loadData() {
        
        recommendVM.requestData {
            
            self.collectionView.reloadData()
            
        }
    }
}

// MARK:- UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate {
    
    
}

// MARK:- UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //  组头个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroup.count
    }
    
    //  每组个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroup[section].anchors.count
    }
    
    //  每个的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroup[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell = CollectionBaseCell()
        
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyFaceCellID, for: indexPath) as! CollectionPrettyFaceCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    
    //  组头内容
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let group = recommendVM.anchorGroup[indexPath.section]
        
        let HeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        HeaderView.anchorGroup = group
        
        return HeaderView
    }
    
    //  设定每个cell 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
