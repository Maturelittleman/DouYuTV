//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/13.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40


class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBar + kNavigation, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    fileprivate lazy var pageContentView: PageContentView = {
        let contentH = kScreenH - kStatusBar - kNavigation - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBar + kNavigation + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        
        //  for循环创建子控制器
        for _ in 0..<4 {
            let VC = UIViewController()
            VC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVCs.append(VC)
        }
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        
        return contentView
    }()

    // MARK:- 系统构造函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension HomeViewController {
    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false

        //  添加导航栏
        setupNavigationBar()
        
        //  添加标题栏
        view.addSubview(pageTitleView)
        
        //  添加内容控制器
        view.addSubview(pageContentView)
    }
    
    // MARK:- 添加导航栏
    private func setupNavigationBar() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
