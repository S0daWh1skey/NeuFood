//
//  EditCommentViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/12/9.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class EditCommentViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var Comment: UITextField!
    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FN: UILabel!
    @IBOutlet var Sum: UILabel!
    @IBOutlet weak var Time: UILabel!
    var Order : NFOrderModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Comment.delegate=self
        Comment.returnKeyType = UIReturnKeyType.done
        let FoodName = Order.foodname as String
        //let FoodNumber = Order.num
        //let Sum = Order.sum
        //print(Order.sum)
        self.FoodName.text = FoodName
        self.FN.text = "\(Order.num as! Int)个"
        self.Sum.text = "\(Order.sum as! Int)元"
        self.Time.text = Order.comment_time! as String
        self.Comment.text = Order.content! as String
        //
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Comment.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Submit(_ sender: Any) {
        let CommentContent = Comment.text! as String
        let orderid = Order.order_id! as Int
        print(orderid)
        let parameters = ["order_id":orderid,
                          "content":CommentContent] as [String : Any]
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_AddComment(parameters as NSDictionary, view: self.view, block: { (flag:NSString) in
            if flag != "0"{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:{
                    MBProgressHUD.showDelayHUDToView(self.view, message: "修改成功")
                    //UIApplication.shared.keyWindow!.rootViewController = NeuFoodMainTabbarViewController()
                })
            }else{
                MBProgressHUD.showDelayHUDToView(self.view, message: "修改不成功")
            }
        })
    }
    
    
    @IBAction func Delete(_ sender: Any) {
        let orderid = Order.order_id! as Int
        let parameters2 = ["order_id":orderid] as [String : Any]
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_DeleteComment(parameters2 as NSDictionary, view: self.view, block: { (flag:NSString) in
            if flag != "0"{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:{
                    MBProgressHUD.showDelayHUDToView(self.view, message: "删除成功")
                    //UIApplication.shared.keyWindow!.rootViewController = NeuFoodMainTabbarViewController()
                })
            }else{
                MBProgressHUD.showDelayHUDToView(self.view, message: "删除不成功")
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController? .setNavigationBarHidden(false, animated: true)
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
