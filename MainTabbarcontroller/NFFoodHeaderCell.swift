//
//  NFFoodHeaderCell.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/2.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit
let CELLHEIGHT: CGFloat = 100.0
let MARGIN: CGFloat = 8.0
let ScreenWidth: CGFloat = UIScreen.main.bounds.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.height
let WHRatio: CGFloat = 133/100.0

class NFFoodHeaderCell: UITableViewCell {

    var foodImageView: UIImageView!
    var foodNameTitle: UILabel!
    var foodName: UILabel!
    var priceTitle: UILabel!
    var price: UILabel!
    var recommandTitle: UILabel!
    var recommand: UILabel!
    var shop_idTitle: UILabel!
    var shop_id: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        foodImageView = UIImageView()
        self.contentView.addSubview(foodImageView)
        
        foodNameTitle = UILabel()
        foodNameTitle.text = "菜品名字"
        foodNameTitle.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(foodNameTitle)
        
        foodName = UILabel()
        self.contentView.addSubview(foodName)
        
        priceTitle = UILabel()
        priceTitle.text = "菜品单价"
        priceTitle.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(priceTitle)
        
        price = UILabel()
        self.contentView.addSubview(price)
        
        recommandTitle = UILabel()
        recommandTitle.text = "推荐指数"
        recommandTitle.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(recommandTitle)
        
        recommand = UILabel()
        self.contentView.addSubview(recommand)
        
        
        shop_idTitle = UILabel()
        shop_idTitle.text = "店铺编号"
        shop_idTitle.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(shop_idTitle)
        
        shop_id = UILabel()
        self.contentView.addSubview(shop_id)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        foodImageView.frame = CGRect(x: 0, y: 0, width: CGFloat(WHRatio*CELLHEIGHT), height: CELLHEIGHT);
        
        foodNameTitle.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN, y: 0, width: 80, height: 20);
        
        foodName.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN + 80, y: 0, width: ScreenWidth-(WHRatio*CELLHEIGHT + MARGIN + 80), height: 20);
        
        priceTitle.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN, y: 20, width: 80, height: 20);
        
        price.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN + 80, y: 20, width: ScreenWidth-(WHRatio*CELLHEIGHT + MARGIN + 80), height: 20);
        
        recommandTitle.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN, y: 40, width: 80, height: 20);
        
        recommand.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN + 80, y: 40, width: ScreenWidth-(WHRatio*CELLHEIGHT + MARGIN + 80), height: 20);
        
        shop_idTitle.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN, y: 60, width: 80, height: 20);
        
        shop_id.frame = CGRect(x: WHRatio*CELLHEIGHT + MARGIN + 80, y: 60, width: ScreenWidth-(WHRatio*CELLHEIGHT + MARGIN + 80), height: 20);
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
