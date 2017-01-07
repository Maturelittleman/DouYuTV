//
//  CycleModel.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/7.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var anchor: AnchorModel?        //  房间信息对应的模型对象

    var title: String = ""          //  房间名
    var pic_url: String = ""        //  封面图片
    var room: [String: NSObject]?{  //  房间信息
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    // MARK:- 系统构造函数
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
