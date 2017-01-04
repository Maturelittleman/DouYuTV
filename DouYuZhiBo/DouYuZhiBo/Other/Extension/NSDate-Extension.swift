//
//  NSDate-Extension.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/3.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import Foundation

extension NSDate {
    
    static func getCurrentTime() -> String {
        
        //当前时间
        let newDate = NSDate()
        
        //计算当前时间的秒
        let interval = Int(newDate.timeIntervalSince1970)
        
        //返回
        return "\(interval)"
    }
    
}
