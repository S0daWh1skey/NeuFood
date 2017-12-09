//
//  NFShopTableViewCell.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/10/26.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class NFShopTableViewCell: UITableViewCell {

//    @IBOutlet weak var ShopLevel: UILabel!
//    @IBOutlet weak var ShopIntro: UILabel!
//    @IBOutlet weak var ShopAddress: UILabel!
//    @IBOutlet weak var ShopName: UILabel!
//    @IBOutlet weak var ShopImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 4, y: 4, width: 72, height: 72)
        var tmpframe = self.textLabel!.frame
        tmpframe.origin.x = 116
        self.textLabel!.frame = tmpframe
    }
    

}
