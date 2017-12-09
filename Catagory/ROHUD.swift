//
//  ROHUD.swift
//  NeuFood
//
//  Created by Albert Sphepherd on 2017/9/28.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import Foundation

extension MBProgressHUD{
    class func showDelayHUDToView(_ view:UIView,message: String) ->Void{
        let HUD = MBProgressHUD(view: view)
        view.addSubview(HUD)
        HUD.offset.y = view.frame.size.height * 1.0/4.0
        HUD.customView = UIImageView(frame: CGRect.zero)
        HUD.mode = MBProgressHUDMode.customView
        HUD.label.text = message
        HUD.show(animated: true)
        HUD.hide(animated: true, afterDelay: 1)
    }
}
