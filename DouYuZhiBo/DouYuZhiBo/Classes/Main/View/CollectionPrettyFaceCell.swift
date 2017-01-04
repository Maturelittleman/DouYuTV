//
//  CollectionPrettyFaceCell.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/31.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionPrettyFaceCell: CollectionBaseCell {
    
    fileprivate var cityBtn = UIButton()        //  城市

    override var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {return}
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
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
extension CollectionPrettyFaceCell {
    
    fileprivate func setupUI() {
        
        //  设置城市
        let cityBtn = UIButton()
        self.addSubview(cityBtn)
        cityBtn.setImage(UIImage(named: "ico_location"), for: .normal)
        cityBtn.setTitle("中国陕西西安", for: .normal)
        cityBtn.setTitleColor(UIColor.darkGray, for: .normal)
        cityBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        self.cityBtn = cityBtn
        cityBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo(0)
            make.height.equalTo(14)
        }
        
        //  设置名称
        let nameLabel = UILabel()
        self.addSubview(nameLabel)
        nameLabel.text = "仲琦"
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        self.nameLabel = nameLabel
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(cityBtn.snp.top).offset(-5)
            make.height.equalTo(16)
            make.width.equalToSuperview()
        }
        
        //  设置头像
        let iconImageV = UIImageView(image: UIImage(named: "live_cell_default_phone"))
        self.addSubview(iconImageV)
        iconImageV.layer.cornerRadius = 8
        iconImageV.layer.masksToBounds = true
        self.iconImageV = iconImageV
        iconImageV.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-5)
        }
        
        //  设置在线人数
        let onlineBtn = UIButton()
        self.addSubview(onlineBtn)
        onlineBtn.setTitle("6666在线", for: .normal)
        onlineBtn.setTitleColor(UIColor.white, for: .normal)
        onlineBtn.backgroundColor = UIColor.darkGray
        onlineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        onlineBtn.layer.cornerRadius = 3
        onlineBtn.layer.masksToBounds = true
        self.onlineBtn = onlineBtn
        onlineBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(20)
            make.top.equalTo(8)
            make.right.equalTo(-8)
        }
    }
}
