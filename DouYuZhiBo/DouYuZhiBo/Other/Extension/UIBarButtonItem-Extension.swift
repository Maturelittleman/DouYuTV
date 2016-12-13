//
//  UIBarButtonItem-Extension.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/13.
//  Copyright © 2016年 Zaki. All rights reserved.
//
//  UiBarButtonItem 的类扩展与构造函数

import UIKit


extension UIBarButtonItem {
    //  类扩展
    /*
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    //  构造函数
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero ) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)

        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)

        }
        
        self.init(customView: btn)
    }
}



