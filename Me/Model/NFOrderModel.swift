//
//  NFOrderModel.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/28.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//
/*"order_id":1,
 "user_id":1,
 "food_id":1,
 "username":"lnn",
 "foodname":"酸菜鱼",
 "num":1,
 "sum":23,
 "suggesttime":null,
 "ordertime":"2016-04-0900:00:00.0",
 "shopname":"满口香川菜",
 "shopaddress":"中国大连",
 "price":23,
 "content":"sichuang",
 "comment_time":"2016-04-10"
*/
import UIKit

class NFOrderModel: NSObject {
    var order_id : NSNumber!
    var user_id : NSString!
    var food_id: NSNumber!
    var username : NSString!
    var foodname:NSString!
    var num : NSNumber!
    var sum : NSNumber!
    var suggesttime : NSString!
    var ordertime : NSString!
    var shopname : NSString!
    var shopaddress : NSString!
    var price : NSNumber!
    var content : NSString!
    var comment_time : NSString!
    
    
    class func orderModelWithDict(_ dict: NSDictionary) -> NFOrderModel{
        let model = NFOrderModel()
        //print("ID=\(userid)")
        //根据字典，进行模型的初始化
        model.setValuesForKeys(dict as! [String:
            AnyObject])
        
        return model
    }
    
}
