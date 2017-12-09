//
//  NFFoodModel.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/10/26.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//
/*
 "food_id" = 6;
 foodname = "\U4e94\U82b1\U8089";
 intro = "\U4e0d\U80a5\U4e0d\U817b";
 pic = "http://i2.muimg.com/593269/804ef719889517d3t.jpg";
 price = 25;
 recommand = 1;
 "shop_id" = 2;
 "type_id" = 2;
 */
import UIKit

class NFFoodModel: NSObject {
    var foodId : NSString!
    var food_id: NSNumber!
    var foodname:NSString!
    var intro: NSString!
    var pic: NSString!
    var price: NSNumber!
    var recommand: NSNumber!
    var shop_id: NSNumber!
    var type_id:NSNumber!
    
    
    class func foodModelWithDict(_ dict: NSDictionary) -> NFFoodModel{
        let model = NFFoodModel()
        let userid = dict.object(forKey: "food_id") as! NSNumber
        //print("ID=\(userid)")
        //根据字典，进行模型的初始化
        model.setValuesForKeys(dict as! [String:
            AnyObject])
        
        return model
    }
    
}
