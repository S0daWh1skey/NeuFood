//
//  NFCShopModel.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/16.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//


/*{
 "user_id":1,
 "food_id":0,
 "shop_id":2,
 "collect_id":35,
 "username":"lnn",
 "foodname":null,
 "shopname":"东北一家人",
 "flag":0,
 "pic":"http://picapi.ooopic.com/01/43/03/11b1OOOPIC53.jpg",
 "price":0,
 "address":"东软食堂三期"
 },
*/

import UIKit

class NFCShopModel: NSObject {
    var shopname: NSString!
    var pic: NSString!
    var user_id: NSNumber!
    var food_id: NSNumber!
    var shop_id: NSNumber!
    var collect_id: NSNumber!
    var username: NSString!
    var flag: NSNumber!
    var price: NSNumber!
    var address: NSString!
    var foodname: NSString!
    
    class func shopModelWithDict(_ dict: NSDictionary)-> NFCShopModel{
        let model = NFCShopModel()
        //根据字典，惊醒模型的初始化
        model.setValuesForKeys(dict as! [String : AnyObject])
        return model
    }
    
}
