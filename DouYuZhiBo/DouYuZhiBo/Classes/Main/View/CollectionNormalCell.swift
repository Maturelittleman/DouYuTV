//
//  CollectionNormalCell.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/31.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    fileprivate var titleLabel = UILabel()      //  房间名
    
    override var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {return}
            titleLabel.text = anchor.room_name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI
extension CollectionNormalCell {
    
    fileprivate func setupUI() {
        
        //  小图标
        let iconImg = UIImageView(image: UIImage(named: "home_live_cate_normal"))
        self.addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.width.equalTo(14)
            make.bottom.equalTo(-10)
        }

        //  封面图
        let iconImageV = UIImageView(image: UIImage(named: "Img_default"))
        iconImageV.layer.cornerRadius = 8
        iconImageV.layer.masksToBounds = true
        self.addSubview(iconImageV)
        self.iconImageV = iconImageV
        iconImageV.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalTo(iconImg.snp.top).offset(-5)
            make.top.equalTo(0)
        }
        //  房间名
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.text = "我爱你"
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        self.titleLabel = titleLabel
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImg.snp.right).offset(5)
            make.bottom.equalTo(iconImg)
            make.width.equalTo(iconImageV.snp.width).offset(-20)
            make.height.equalTo(iconImg)
        }
        //  主播名
        let nameLabel = UILabel()
        self.addSubview(nameLabel)
        nameLabel.text = "谷梦露"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 11)
        self.nameLabel = nameLabel
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconImageV.snp.bottom).offset(-5)
            make.left.equalTo(5)
        }
        //  在线人数
        let onlineBtn = UIButton()
        self.addSubview(onlineBtn)
        onlineBtn.setTitle("6666在线", for: .normal)
        onlineBtn.setImage(UIImage(named:"Image_online"), for: .normal)
        onlineBtn.setTitleColor(UIColor.white, for: .normal)
        onlineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        onlineBtn.layer.cornerRadius = 3
        onlineBtn.layer.masksToBounds = true
        self.onlineBtn = onlineBtn
        onlineBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.bottom.equalTo(iconImageV.snp.bottom).offset(-5)
        }
    }
}
