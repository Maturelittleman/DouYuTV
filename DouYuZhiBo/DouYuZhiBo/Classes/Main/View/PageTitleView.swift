//
//  PageTitleView.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2016/12/14.
//  Copyright © 2016年 Zaki. All rights reserved.
//

import UIKit

private let kTitleLine: CGFloat = 2

private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

//  定义协议
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

class PageTitleView: UIView {

    // MARK:- 定义属性
    fileprivate var titles: [String]
    fileprivate var currentIndex : Int = 0 //  点击的角标
    weak var delegate: PageTitleViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
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
            //  创建label,设置lebel的属性
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center //    居中显示
            //  设置label的Frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //  添加手势
            label.isUserInteractionEnabled = true //    是否允许用户点击
            let tapG = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapG:)))
            label.addGestureRecognizer(tapG)
            //添加到scrollView中
            scrollView.addSubview(label)
            //保存到数组中
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
        addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kTitleLine, width: firstLabel.frame.size.width, height: kTitleLine)
    }
}

// MARK:- label的点击事件
extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapG: UITapGestureRecognizer) {
        
        //  设置老按钮点击的字体
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //  设置点击按钮的字体
        guard let clickLabel = tapG.view as? UILabel else {return}
        clickLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)

        //  保存点击的按钮
        currentIndex = clickLabel.tag
        
        //  点击按钮下划线的动画效果
        let titleLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollLine.frame.origin.x = titleLineX
        })
        
        //  代理方法:将点击事件传出去
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageTitleView {
 
    func setCurrentTitleLabel(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        //保存当前点击的Label
        currentIndex = targetIndex
        
        // 取出需要改变的Label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //  处理标题线的逻辑
        let moveTotalX = sourceLabel.frame.origin.x - targetLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x - moveX
        
        //  取出颜色变化的范围
        let colorChange = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        //  改变sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorChange.0 * progress, g:kSelectColor.1 - colorChange.1 * progress , b: kSelectColor.2 - colorChange.2 * progress)

        //  改变targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorChange.0 * progress, g: kNormalColor.1 + colorChange.1 * progress, b: kNormalColor.2 + colorChange.2 * progress)
    }
}



