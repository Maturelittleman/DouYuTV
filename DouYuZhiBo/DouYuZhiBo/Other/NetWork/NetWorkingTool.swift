//
//  NetWorking.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/31.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetWorkingTool {
    
    class func requestData(_ type: MethodType, URLString: String, parameters : [String: Any]? = nil, finishedCallback : @escaping ( _ result : Any) -> ()) {
        
        //  获取请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //  请求数据
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (resopnse) in
            
            //  获取结果
            guard let result = resopnse.result.value else {
                print(resopnse.result.error! )
                return
            }
            
            //  返回结果
            finishedCallback(result)
        }
    }
}
