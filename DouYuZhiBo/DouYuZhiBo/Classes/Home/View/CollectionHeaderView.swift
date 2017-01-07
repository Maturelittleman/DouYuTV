//
//  CollectionHeaderView.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/31.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    fileprivate var imageView = UIImageView()
    fileprivate var titleLabel = UILabel()
    
    var anchorGroup: AnchorGroup? {
        didSet {
            titleLabel.text = anchorGroup?.tag_name
            imageView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
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

extension CollectionHeaderView {
    
    fileprivate func setupUI() {
        //  分界线
        let lineView = UIView()
        self.addSubview(lineView)
        lineView.backgroundColor = UIColor(r: 234, g: 234, b: 234)
        
        lineView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(10)
            make.left.equalTo(0)
            make.top.equalTo(0)
        }
        
        //  图标
        let imageView = UIImageView(image: UIImage(named: "home_header_normal"))
        self.addSubview(imageView)
        self.imageView = imageView
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(18)
            make.width.equalTo(18)
            make.top.equalTo(lineView.snp.bottom).offset(11)
            make.left.equalTo(10)
        }
        
        //  文字
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.text = "颜值"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.black
        self.titleLabel = titleLabel
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageView.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(5)
        }
        
        //  按钮
        let btn = UIButton()
        btn.setTitle("更多 >", for: .normal)
        self.addSubview(btn)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageView.snp.centerY)
            make.right.equalTo(-10)
            make.width.equalTo(50)
        }
        
    }
}
