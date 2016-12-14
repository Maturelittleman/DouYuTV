//
//  PageTitleView.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/14.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

private let kTitleLine: CGFloat = 2

class PageTitleView: UIView {

    // MARK:- 定义属性
    fileprivate var titles: [String]

    
    // MARK:- 懒加载属性
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    fileprivate lazy var titleLine: UIView = {
        let titleLine = UIView()
        titleLine.backgroundColor = UIColor.orange
        return titleLine
    }()
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageTitleView {
    
    fileprivate func setupUI() {
        //  添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //  添加内容view
        setupTitleLabels()
        //  添加底线view
        setupBottomLineAndTitleLine()
    }
    
    // MARK:- 设置内容label
    private func setupTitleLabels() {
        
        let labelH: CGFloat = frame.height - kTitleLine
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelY: CGFloat = 0

        for(index, title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            
            let labelX: CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAndTitleLine() {
        //  添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //  添加标题线
        addSubview(titleLine)
        
        guard let firstLabel = titleLabels.first else {return}
        
        firstLabel.textColor = UIColor.orange
        
        titleLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kTitleLine, width: firstLabel.frame.size.width, height: kTitleLine)
        
    }
}
