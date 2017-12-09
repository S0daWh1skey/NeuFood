//
//  NFShopModel.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/10/26.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//
/*
 address = "\U4e1c\U8f6f\U98df\U5802\U4e09\U671f";
 comment = "<null>";
 intro = "\U5f88\U597d\U5403\U7684\U9178\U83dc\U9c7c";
 level = 6;
 phonenum = 18858988983;
 pic = "http://img3.redocn.com/tupian/20141126/xiangxiwaipocai_3613936.jpg";
 "shop_id" = 7;
 shopname = "\U6ee1\U53e3\U9999\U5ddd\U83dc";
 */
import UIKit

class NFShopModel: NSObject {

    var shop_id: NSNumber!
    var shopname: NSString!
    var address: NSString!
    var phonenum: NSString!
    var intro: NSString!
    var pic: NSString!
    var comment: NSString!
    var level: NSString!
    
    class func shopModelWithDict(_ dict: NSDictionary)-> NFShopModel{
        let model = NFShopModel()
        //根据字典，惊醒模型的初始化
        model.setValuesForKeys(dict as! [String : AnyObject])
        return model
    }
    
    
    
}
