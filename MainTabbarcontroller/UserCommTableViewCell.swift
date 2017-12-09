//
//  UserCommTableViewCell.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/28.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class UserCommTableViewCell: UITableViewCell {
    @IBOutlet weak var Comment: UILabel!
    
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var CommTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
