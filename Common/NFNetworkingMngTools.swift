//
//  NFNetworkingMngTools.swift
//  NeuFood
//
//  Created by Albert Sphepherd on 2017/9/22.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//


import Foundation
//http://60.205.189.39/userLogin.do?username=lnn&userpass=11
//http://60.205.189.39/
//API
var userId : NSString!
var foodId : NSString!
let str = "http://60.205.189.39/userLogin.do?"
typealias NetworkBlock = (_ flag:String)->Void
let signle = NFNetworkMngTool()
class NFNetworkMngTool:NSObject{
    
    static var shared = NFNetworkMngTool() //
    
    class func sharedNetworkingTool() -> NFNetworkMngTool{
        return signle
    }
    
    func NFNetwork_Login(_ parameters:NSDictionary,block:NetworkBlock?){
        let paraArray = NSMutableArray()
        for (key,value) in parameters{
            let str = "\(key)=\(value)"
            paraArray.add(str)
            print(paraArray)
        }
        let body = paraArray.componentsJoined(by: "&")
        let url = URL(string: str)
        var request = URLRequest(url: url!)
        request.httpMethod = "post"
        request.httpBody = body.data(using: String.Encoding.utf8)
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            //对返回数据进行处理
            if data != nil{
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    //将返回的数据封装成模型对象
                    let model = LoginReturnJson.LoginReturnJsonWithDict(json as? NSDictionary)
                    if model?.error == nil{
                        
                        block!("1")
                    }
                    else{
                        block!("0")
                    }
                }
            }
        })
        dataTask.resume() //启动任务
        
    }
    
    func NFNetwor_Logon(_ parameters:NSDictionary,view: UIView, block: @escaping (_ flag: NSString)->Void){
        let NF_Logon: String = "http://60.205.189.39/userLogin.do"
        MBProgressHUD.showAdded(to: view, animated: true)
        let afManager = AFHTTPRequestOperationManager()
        afManager.get(NF_Logon, parameters: parameters,
                      success: { (operation: AFHTTPRequestOperation?, responseObject:Any?) in
            MBProgressHUD.hide(for: view, animated: true)
                        let logonReturnModel = NFLogonReturnModel.logonReturnModelWithDict(responseObject as! NSDictionary)
                        //当成功登陆后保存用户名和密码
                        if logonReturnModel.userId != "0"{
                            userId = logonReturnModel.userId
                            block("1")
                        }else{
                            MBProgressHUD.showDelayHUDToView(view, message: logonReturnModel.msg as String)
                            block("0")
                        }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
            block("0")
        })
    }
    
    
    func NFNetwork_GetShopListView(_ view: UIView, block:@escaping(_ shopList:NSArray)->Void){
        let ShopList:String = "http://60.205.189.39/getAllShops.do"
        MBProgressHUD.showAdded(to: view, animated: true)
        
       let manager = AFHTTPRequestOperationManager()
        
        manager.post(ShopList, parameters: nil, success: {(operation:AFHTTPRequestOperation?,responseObject:Any?)->Void in
         MBProgressHUD.hide(for: view, animated: true)
//            print("店铺信息")
//            print(responseObject as Any)
//            print("店铺信息")
            let shopArray = responseObject as! NSArray
            let shopMutableArray: NSMutableArray = NSMutableArray()
            
            for ashopDict in shopArray{
                let shopDict = ashopDict as! NSDictionary
                let shop: NFShopModel = NFShopModel.shopModelWithDict(shopDict)
                shopMutableArray.add(shop)
            }
            block(shopMutableArray)
            
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
        
        
    }
    //获取店铺下的菜单列表
    func NFNetwork_GetFoodListParameters(_ parameters:NSDictionary, view: UIView, block:@escaping(_ courseList: NSArray)->Void) -> Void{
        let NF_GetFoodList: String =  "http://60.205.189.39/getFoodByShop.do"
        //在开始网络加载前任务指示器开始转
        MBProgressHUD.showAdded(to: view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        print(parameters)
        manager.post(NF_GetFoodList, parameters: parameters, success: {(operation:AFHTTPRequestOperation?, responseObject: Any?)->Void in
            MBProgressHUD.hide(for: view, animated: true)
            //将返回的字典转换为模型对象
            print("菜单列表")
              print(responseObject)
//            print("菜单列表")
            let foodArray = responseObject as! NSArray
            let foodMutableArray:NSMutableArray =
                NSMutableArray()
            
            for afoodDict in foodArray{
                let foodDict = afoodDict as! NSDictionary
                let food: NFFoodModel =
                NFFoodModel.foodModelWithDict(foodDict)
                foodMutableArray.add(food)
            }
            block(foodMutableArray);
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
    }
    //判断是否收藏
    func NFNetwork_isCollectedWithParameters(_ parameters: NSDictionary, view: UIView, block: @escaping (_ flag:NSString) -> Void) -> Void{
        let NF_isCollected: String = "http://60.205.189.39/isCollected.do"
        let manager = AFHTTPRequestOperationManager()
        manager.post(NF_isCollected, parameters: parameters, success: { (operation:
            AFHTTPRequestOperation?, resposeObject:Any?) -> Void in
            let res = resposeObject as! NSDictionary
            let collected = res.object(forKey: "collected")
            as! NSString
            if collected == "1"{
                block("1")
            }else{
                block("0")
            }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因判断失败")
        })
    }
    func NFNetwork_CollectShopWithParameters(_ parameters: NSDictionary, view: UIView, block: @escaping (_ flag:NSString) -> Void) -> Void{
        let NF_CollectShop: String = "http://60.205.189.39/userCollectShop.do"
        let manager = AFHTTPRequestOperationManager()
        //print(parameters)
        manager.post(NF_CollectShop, parameters: parameters, success: { (operation:
            AFHTTPRequestOperation?, resposeObject:Any?) -> Void in
            let res = resposeObject as! NSDictionary
            let collected = res.object(forKey: "success")
                as! NSString
            if collected == "1"{
                block("1")
            }else{
                block("0")
            }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因收藏失败")
        })
    }
    func NFNetwork_CollectFoodWithParameters(_ parameters: NSDictionary, view: UIView, block: @escaping (_ flag:NSString) -> Void) -> Void{
        let NF_CollectShop: String = "http://60.205.189.39/userCollectFood.do"
        let manager = AFHTTPRequestOperationManager()
        //print(parameters)
        manager.post(NF_CollectShop, parameters: parameters, success: { (operation:
            AFHTTPRequestOperation?, resposeObject:Any?) -> Void in
            let res = resposeObject as! NSDictionary
            let collected = res.object(forKey: "success")
                as! NSString
            if collected == "1"{
                block("1")
            }else{
                block("0")
            }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因收藏失败")
        })
    }
    //获取用户信息
    func NFNetwork_GetUserById(_ parameters:NSDictionary, view: UIView, block:@escaping(_ courseList: NSDictionary)->Void) -> Void{
        let NF_GetUser: String =  "http://60.205.189.39/getUserById.do"
        //在开始网络加载前任务指示器开始转
        MBProgressHUD.showAdded(to: view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        manager.post(NF_GetUser, parameters: parameters, success: {(operation:AFHTTPRequestOperation?, responseObject: Any?)->Void in
            MBProgressHUD.hide(for: view, animated: true)
            //将返回的字典转换为模型对象
            //print("菜单列表")
            //print(responseObject)
            //            print("菜单列表")
            let userArray = responseObject as! NSDictionary
//            let userMutableArray:NSMutableArray =
//                NSMutableArray()
            
//            for auserDict in userArray{
//                let userDict = auserDict as! NSDictionary
//                let user: NFUserModel =
//                    NFUserModel.userModelWithDict(userDict)
//                userMutableArray.add(user)
//            }
            block(userArray);
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
    }
    
    //修改用户数据
    func NFNetwork_UpdateInfo(_ parameters: NSDictionary, view: UIView, block: @escaping (_ flag:NSString) -> Void) -> Void{
        let NF_CollectShop: String = "http://60.205.189.39/updateUserById.do"
        //http://60.205.189.39/updateUserById.do?user_id=1&username=lnn&userpass=11&mobilenum= 13476543211&address=大连
        let manager = AFHTTPRequestOperationManager()
        //print(parameters)
        manager.post(NF_CollectShop, parameters: parameters, success: { (operation:
            AFHTTPRequestOperation?, resposeObject:Any?) -> Void in
            let res = resposeObject as! NSDictionary
            let collected = res.object(forKey: "success")
                as! NSString
            if collected == "1"{
                block("1")
            }else{
                block("0")
            }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因修改失败")
        })
    }
    
    //获取用户的所有收藏商铺
    func NFNetwork_GetUserCollectionShop(_ parameters:NSDictionary, view: UIView, block:@escaping(_ courseList: NSArray)->Void) -> Void{
        let NF_GetFoodList: String =  "http://60.205.189.39/getAllUserCollection.do"
        //在开始网络加载前任务指示器开始转
        MBProgressHUD.showAdded(to: view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        manager.post(NF_GetFoodList, parameters: parameters, success: {(operation:AFHTTPRequestOperation?, responseObject: Any?)->Void in
            MBProgressHUD.hide(for: view, animated: true)
            //将返回的字典转换为模型对象
            print("菜单列表")
            print(responseObject)
            //            print("菜单列表")
            let collectionshopArray = responseObject as! NSArray
            let collectionshopMutableArray:NSMutableArray =
                NSMutableArray()
            
            for aCshopDict in collectionshopArray{
                let CollectionShopDict = aCshopDict as! NSDictionary
                let collectionshop: NFCShopModel = NFCShopModel.shopModelWithDict(CollectionShopDict)
                    //NFCShopModel.shopModelWithDict(shopDict)
                collectionshopMutableArray.add(collectionshop)
            }
            block(collectionshopMutableArray);
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
    }
    
    //获取搜索结果
    func NFNetwork_GetSearchResult(_ parameters:NSDictionary, view: UIView, block:@escaping(_ courseList: NSArray)->Void) -> Void{
        let NF_GetFoodList: String =  "http://60.205.189.39/getFoodBySearch.do"
        //在开始网络加载前任务指示器开始转
        MBProgressHUD.showAdded(to: view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        manager.post(NF_GetFoodList, parameters: parameters, success: {(operation:AFHTTPRequestOperation?, responseObject: Any?)->Void in
            MBProgressHUD.hide(for: view, animated: true)
            //将返回的字典转换为模型对象
            print("菜单列表")
            print(responseObject)
            //            print("菜单列表")
            let foodArray = responseObject as! NSArray
            let foodMutableArray:NSMutableArray =
                NSMutableArray()
            
            for afoodDict in foodArray{
                let foodDict = afoodDict as! NSDictionary
                let food: NFFoodModel =
                    NFFoodModel.foodModelWithDict(foodDict)
                foodMutableArray.add(food)
            }
            block(foodMutableArray);
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
    }
    
    //获取评论详情
    func NFNetwork_GetFoodOrderListParameters(_ parameters:NSDictionary, view: UIView, block:@escaping(_ courseList: NSArray)->Void) -> Void{
        let NF_GetFoodList: String =  "http://60.205.189.39/getAllUserFoodOrder.do"
        //在开始网络加载前任务指示器开始转
        MBProgressHUD.showAdded(to: view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        print(parameters)
        manager.post(NF_GetFoodList, parameters: parameters, success: {(operation:AFHTTPRequestOperation?, responseObject: Any?)->Void in
            MBProgressHUD.hide(for: view, animated: true)
            //将返回的字典转换为模型对象
            print("评论列表")
            print(responseObject)
            //            print("菜单列表")
            let orderArray = responseObject as! NSArray
            let orderMutableArray:NSMutableArray =
                NSMutableArray()
            
            for aorderDict in orderArray{
                let orderDict = aorderDict as! NSDictionary
                let order: NFOrderModel =
                    NFOrderModel.orderModelWithDict(orderDict)
                orderMutableArray.add(order)
            }
            block(orderMutableArray);
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
    }
    
    
    
    //获取用户购买过的订单
    func NFNetwork_GetUserOrderListParameters(_ parameters:NSDictionary, view: UIView, block:@escaping(_ courseList: NSArray)->Void) -> Void{
        let NF_GetFoodList: String =  "http://60.205.189.39/getAllUserOrder.do"
        //在开始网络加载前任务指示器开始转
        MBProgressHUD.showAdded(to: view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        print(parameters)
        manager.post(NF_GetFoodList, parameters: parameters, success: {(operation:AFHTTPRequestOperation?, responseObject: Any?)->Void in
            MBProgressHUD.hide(for: view, animated: true)
            //将返回的字典转换为模型对象
            print("评论列表")
            print(responseObject as Any)
            //            print("菜单列表")
            MBProgressHUD.hide(for: view, animated: true)
            let orderArray = responseObject as! NSArray
            let orderMutableArray:NSMutableArray =
                NSMutableArray()
            
            for aorderDict in orderArray{
                let orderDict = aorderDict as! NSDictionary
                let order: NFOrderModel =
                    NFOrderModel.orderModelWithDict(orderDict)
                orderMutableArray.add(order)
            }
            block(orderMutableArray);
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
    }
    
    
    
    //确认订单
    func NFNetwork_ConfirmOrder(_ parameters: NSDictionary, view: UIView, block: @escaping (_ flag:NSString) -> Void) -> Void{
        let NF_ConfirmOrder: String = "http://60.205.189.39/insertOrder.do"
        let manager = AFHTTPRequestOperationManager()
        //print(parameters)
        manager.post(NF_ConfirmOrder, parameters: parameters, success: { (operation:
            AFHTTPRequestOperation?, resposeObject:Any?) -> Void in
            let res = resposeObject as! NSDictionary
            let collected = res.object(forKey: "success")
                as! NSString
            if collected == "1"{
                block("1")
            }else{
                block("0")
            }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因下单失败")
        })
    }
    
    //获取用户购买过的订单的评论
    func NFNetwork_GetUserCommListParameters(_ parameters:NSDictionary, view: UIView, block:@escaping(_ courseList: NSArray)->Void) -> Void{
        let NF_GetFoodList: String =  "http://60.205.189.39/getAllUserComment.do"
        //在开始网络加载前任务指示器开始转
        //MBProgressHUD.showAdded(to: view, animated: true)
        let manager = AFHTTPRequestOperationManager()
        print(parameters)
        manager.post(NF_GetFoodList, parameters: parameters, success: {(operation:AFHTTPRequestOperation?, responseObject: Any?)->Void in
            MBProgressHUD.hide(for: view, animated: true)
            //将返回的字典转换为模型对象
            print("评论列表")
            print(responseObject as Any)
            //            print("菜单列表")
            MBProgressHUD.hide(for: view, animated: true)
            let orderArray = responseObject as! NSArray
            let orderMutableArray:NSMutableArray =
                NSMutableArray()
            
            for aorderDict in orderArray{
                let orderDict = aorderDict as! NSDictionary
                let order: NFOrderModel =
                    NFOrderModel.orderModelWithDict(orderDict)
                orderMutableArray.add(order)
            }
            block(orderMutableArray);
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因加载失败")
        })
    }
    
    
    //添加/修改 评论
    func NFNetwork_AddComment(_ parameters: NSDictionary, view: UIView, block: @escaping (_ flag:NSString) -> Void) -> Void{
        let NF_AddComment: String = "http://60.205.189.39/insertComment.do"
        let manager = AFHTTPRequestOperationManager()
        //print(parameters)
        manager.post(NF_AddComment, parameters: parameters, success: { (operation:
            AFHTTPRequestOperation?, resposeObject:Any?) -> Void in
            let res = resposeObject as! NSDictionary
            let collected = res.object(forKey: "success")
                as! NSString
            if collected == "1"{
                block("1")
            }else{
                block("0")
            }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因评论失败")
        })
    }
    
    //删除评论
    func NFNetwork_DeleteComment(_ parameters: NSDictionary, view: UIView, block: @escaping (_ flag:NSString) -> Void) -> Void{
        let NF_DeleteComment: String = "http://60.205.189.39/deleteComment.do"
        let manager = AFHTTPRequestOperationManager()
        //print(parameters)
        manager.post(NF_DeleteComment, parameters: parameters, success: { (operation:
            AFHTTPRequestOperation?, resposeObject:Any?) -> Void in
            let res = resposeObject as! NSDictionary
            let collected = res.object(forKey: "success")
                as! NSString
            if collected == "1"{
                block("1")
            }else{
                block("0")
            }
        }, failure: {(operation:
            AFHTTPRequestOperation?, error: Error?) -> Void in
            //失败跳转
            MBProgressHUD.hide(for: view, animated: true)
            MBProgressHUD.showDelayHUDToView(view, message: "网络原因删除失败")
        })
    }
    
    
}

