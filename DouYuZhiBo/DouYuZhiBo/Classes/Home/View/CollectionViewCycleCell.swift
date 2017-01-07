//
//  CollectionViewCycleCell.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/7.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class CollectionViewCycleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            
            let url = URL(string: cycleModel?.pic_url ?? "")!
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
