//
//  CollectionBaseCell.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/4.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    var nameLabel = UILabel()       //  名称
    var iconImageV = UIImageView()  //  封面图片
    var onlineBtn = UIButton()      //  在线
    
    var anchor: AnchorModel? {
        didSet{
            //  校验数据
            guard let anchor = anchor else {
                return
            }
            //  用户名称
            nameLabel.text = anchor.nickname
            
            //  设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageV.kf.setImage(with: iconURL)
            
            //  设置在线人数
            var onlineStr = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
        }
    }
}
