//
//  CollectionViewGameCell.swift
//  DouYuZhiBo
//
//  Created by 仲琦 on 2017/1/7.
//  Copyright © 2017年 Zaki. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var baseGame: AnchorGroup? {
        didSet{
            nameLabel.text = baseGame?.tag_name
            
            if let url = URL(string: baseGame?.icon_url ?? "") {
                imageView.kf.setImage(with: url)
            }else {
                imageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
