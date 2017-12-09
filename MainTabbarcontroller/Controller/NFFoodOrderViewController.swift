//
//  FoodOrderViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/28.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class NFFoodOrderViewController: UIViewController {
    //var food : NFFoodModel!
    @IBOutlet weak var dpicker: UIDatePicker!
    var foodName : NSString!
    var imgSrc : NSString!
    var foodPrice : NSNumber!
    var foodNumber : NSNumber!
    var sumprice : NSNumber!
    var foodid : NSNumber!
    let userID : NSString = userId
    var number : Int = 1
    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var Foodname: UILabel!
    @IBOutlet weak var FoodImg: UIImageView!
    @IBOutlet weak var FoodPric: UILabel!
    @IBOutlet weak var FoodNUm: UILabel!
    @IBOutlet weak var SumPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(foodName)
//        print(userID as Any)
//        print(imgSrc)
        print(foodid)
        Foodname.text = foodName! as String
        FoodPric.text = "\(foodPrice!)元"
        let imageStr = imgSrc
        //print(FoodNUm.text)
        //foodNumber = FoodNUm.text as! NSNumber
        //print(foodNumber)
        let imageURL = URL(string: imageStr as! String)
        self.FoodImg.setImageWith(imageURL, placeholderImage: UIImage(named:"placeHolder"))
        sumprice = Int(foodPrice) * 1 as NSNumber
        self.SumPrice.text = "\(sumprice!)元"
        //self.title = "确认订单"
        // Do any additional setup after loading the view.
//        let imageStr = food.pic
//        let imageURL = URL(string: imageStr as! String)
//        self.FoodImg.setImageWith(imageURL, placeholderImage: UIImage(named:"placeHolder"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Stepper(_ sender: Any) {
        number = Int(Stepper.value)
        print(number)
        FoodNUm.text = "\(number)"
        sumprice = Int(foodPrice) * number as NSNumber
        self.SumPrice.text = "\(sumprice!)元"
    }
    
    @IBAction func Confirm(_ sender: UIButton) {
        let date = dpicker.date
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "HH:mm:ss"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        let  parameters1 = ["user_id":userID,
                            "food_id":"\(foodid!)",
                            "num":"\(number)",
                            "sum":"\(sumprice!)",
                            "suggesttime":"\(datestr)"] as [String : Any]
        print(parameters1)
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_ConfirmOrder(parameters1 as NSDictionary, view: self.view, block: { (flag:NSString) in
            if flag != "0"{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:{
                    MBProgressHUD.showDelayHUDToView(self.view, message: "购买成功")
                    //UIApplication.shared.keyWindow!.rootViewController = NeuFoodMainTabbarViewController()
                })
            }else{
                MBProgressHUD.showDelayHUDToView(self.view, message: "购买不成功")
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
