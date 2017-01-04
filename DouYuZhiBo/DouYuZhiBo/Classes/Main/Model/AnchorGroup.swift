//
//  AnchorGroup.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/3.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject{
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    var tag_name: String = ""   //  分组名称
    
    var icon_url: String = ""   //  图标URL
    
    var icon_name: String = "home_header_normal"   //  图标名称
    
    var room_list: [[String: NSObject]]? {  //  房间信息
        didSet{
            //  数据校验
            guard let room_list = room_list else {return}
            //  遍历数据
            for dict in room_list {
                let model = AnchorModel(dict: dict)
                anchors.append(model)
            }
        }
    }
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    //  重写 KVC 遇到空值报错的方法,  以防崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
