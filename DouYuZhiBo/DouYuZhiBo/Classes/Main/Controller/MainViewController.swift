//
//  MainViewController.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/13.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(StoryboardName: "Home")
        addChildVC(StoryboardName: "Live")
        addChildVC(StoryboardName: "Follow")
        addChildVC(StoryboardName: "Me")
    }
    
    private func addChildVC(StoryboardName: String) {
        
        let childVC = UIStoryboard(name: StoryboardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
    }

}
