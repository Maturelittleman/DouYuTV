//
//  RecommendViewController.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/31.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

fileprivate let kCycleViewH = kScreenW * 3 / 8  //  轮播器高度
fileprivate let kGameViewH : CGFloat = 90   //  游戏栏高度

class RecommendViewController: BaseAnchorViewController {
    
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    //  轮播器
    fileprivate lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView(frame: CGRect(x: 0, y: -kCycleViewH - kGameViewH, width: kScreenW, height: kCycleViewH))
        
        return cycleView
    }()
    //  游戏栏
    fileprivate lazy var gameView: RecommendGameView = {
       let gameView = RecommendGameView(frame: CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH))
        
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK:- 设置UI
extension RecommendViewController {
     override func setupUI() {
        
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsetsMake( kCycleViewH + kGameViewH, 0, 0, 0)
    }
}

// MARK:- 网络请求
extension RecommendViewController {
     override func loadData() {
        
        baseVM = recommendVM
        
        //  获取推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.anchorGroups
            
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup =  AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        //  获取无限轮播的数据
        recommendVM.requestCycleData { 
            self.cycleView.cycleModels = self.recommendVM.cycleArray
        }
        
        loadDataFinished()
    }
}

// MARK:- UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDelegateFlowLayout   {
    
    //  每个的内容
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 1{
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyFaceCellID , for: indexPath) as! CollectionPrettyFaceCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    //  设定每个cell 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
