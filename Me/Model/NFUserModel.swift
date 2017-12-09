//
//  NFUserModel.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/9.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//
/*  address = "<null>";
 comment = "\U6d4b\U8bd5";
 mobilenum = "";
 "user_id" = 1;
 username = lnn;
 userpass = 6512bd43d9caa6e02c990b0a82652dca;*/
import UIKit

    class NFUserModel: NSObject {
        var username:NSString!
        var mobilenum:NSString!
        
        
        class func userModelWithDict(_ dict: NSDictionary) -> NFUserModel{
            let model = NFUserModel()
            //let userid = dict.object(forKey: "food_id") as! NSNumber
            //print("ID=\(userid)")
            //根据字典，进行模型的初始化
            model.setValuesForKeys(dict as! [String:
                AnyObject])
            
            return model
        }
}
