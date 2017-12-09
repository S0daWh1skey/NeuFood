//
//  NFLogonReturnModel.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/10/31.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class NFLogonReturnModel: NSObject {
    var msg: NSString!
    var userId: NSString!
    
    class func logonReturnModelWithDict(_ dict: NSDictionary)
        -> NFLogonReturnModel {
            let model = NFLogonReturnModel()
            let userid = dict.object(forKey: "userid") as! NSString
            model.userId = userid
            
            if userid == "0"{
                let msg = "用户名或密码错误"
                model.msg = msg as NSString
            }
            return model
    }
}
