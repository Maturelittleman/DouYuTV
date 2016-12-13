//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/13.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

extension HomeViewController {
    fileprivate func setupUI() {
        setupNavigationBar()
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
