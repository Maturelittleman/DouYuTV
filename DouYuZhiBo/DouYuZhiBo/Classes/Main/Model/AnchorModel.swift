//
//  AnchorModel.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/4.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    
    var room_id : Int = 0   // 房间ID
    
    var vertical_src : String = ""  // 房间图片对应的URLString
    
    var isVertical : Int = 0    // 房间图片对应的URLString 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    
    var room_name : String = "" // 房间名称
    
    var nickname : String = ""  // 主播昵称
   
    var online : Int = 0     // 观看人数
    
    var anchor_city : String = ""   // 所在城市
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
