//
//  RecommendViewModel.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/3.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    
    lazy var cycleArray: [CycleModel] = [CycleModel]()
    
    lazy var bigDataArray: AnchorGroup = AnchorGroup()

    lazy var prettyDataArray: AnchorGroup = AnchorGroup()
}


// MARK:- 发送网络请求
extension RecommendViewModel {
    
    //获取推荐数据
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
                self.anchorGroups.append(group)
            }
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyDataArray, at: 0)
            self.anchorGroups.insert(self.bigDataArray, at: 0)
            
            finishCallBack()
        }
    }
    
    //  获取 轮播图数据
    func requestCycleData (_ finishCallBack: @escaping () -> ()) {
        
        NetWorkingTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "2.421"]) { (result) in
            
            guard let resultData = result as? [String: NSObject] else { return }
            guard let dataArray = resultData["data"] as? [[String: NSObject]] else { return }
            
            for dict in dataArray {
                let cycle = CycleModel(dict: dict)
                self.cycleArray.append(cycle)
            }
            
            finishCallBack()
        }
    }
}
