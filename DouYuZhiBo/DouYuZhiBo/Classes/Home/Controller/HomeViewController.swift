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
    
    // MARK:- 懒加载标题栏
    fileprivate lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBar + kNavigation, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
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

        // MARK:- 添加导航栏
        setupNavigationBar()
        
        // MARK:- 添加标题栏
        view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
}
