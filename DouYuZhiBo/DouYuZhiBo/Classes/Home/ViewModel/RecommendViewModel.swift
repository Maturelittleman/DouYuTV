//
//  RecommendViewModel.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/3.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    lazy var anchorGroup: [AnchorGroup] = [AnchorGroup]()
    
    lazy var bigDataArray: AnchorGroup = AnchorGroup()

    lazy var prettyDataArray: AnchorGroup = AnchorGroup()
}


// MARK:- 发送网络请求
extension RecommendViewModel {
    
    func requestData(_ finishCallBack: @escaping ()-> ()) {
        
        let dGroup = DispatchGroup()
    
        let parameters = [ "limit": 4, "offset": 0, "time": NSDate.getCurrentTime()] as [String : Any]
        //获取第一组数据 最热数据
        dGroup.enter()
        NetWorkingTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom"){ (result) in
        
            guard let resultDict = result as? [String : NSObject] else { return}
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return}
            
            self.bigDataArray.tag_name = "热门"
            self.bigDataArray.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataArray.anchors.append(anchor)
            }
            dGroup.leave()
        }
        //获取第二组数据 颜值数据
        dGroup.enter()
        NetWorkingTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String: NSObject] else { return}
            
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            
            self.prettyDataArray.tag_name = "颜值"
            self.prettyDataArray.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyDataArray.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        //获取第三组数据 其他数据
        dGroup.enter()
        NetWorkingTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //  获取整体数据
            guard let resultDict = result as? [String: NSObject] else {return}
            //  取出界面数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            //  遍历界面数据
            for dict in dataArray {
                //  字典转模型
                let group = AnchorGroup(dict: dict)
                //  添加到数组中
                self.anchorGroup.append(group)
            }
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroup.insert(self.prettyDataArray, at: 0)
            self.anchorGroup.insert(self.bigDataArray, at: 0)
            
            finishCallBack()
        }
    }
}
