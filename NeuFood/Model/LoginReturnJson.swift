//
//  LoginReturnJson.swift
//  NeuFood
//
//  Created by Albert Sphepherd on 2017/9/22.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import Foundation
/*{
 "id": "7"
 }*/
class LoginReturnJson: NSObject{
    var id:String?
    var error:String?
    
    class func LoginReturnJsonWithDict(_ dict:NSDictionary?)->LoginReturnJson?{
        if dict == nil {
            return nil
        }
        
        let model:LoginReturnJson? = LoginReturnJson()
        if dict?.count == 2 {
            if model != nil{
                model?.id = dict!["id"] as? String
            }
        }
        else{
            model?.error = dict!["error"] as? String
        }
        
        return model
    }
    
}
