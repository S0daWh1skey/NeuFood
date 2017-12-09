//
//  NFFoodDetailViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/7.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class NFFoodDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
     var orderList:NSArray = NSArray()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.orderList.count == 0{
            return 0
        }
        return self.orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CommCell", for: indexPath)
        let cell: UserCommTableViewCell = self.CommTableView.dequeueReusableCell(withIdentifier: "CommList") as! UserCommTableViewCell
        if self.orderList.count != 0{
            let order: NFOrderModel = self.orderList[(indexPath as NSIndexPath).row] as! NFOrderModel
            //cell.textLabel!.text = order.content as String
            cell.Comment.text = order.content as String
            cell.Username.text = order.username as String
            cell.CommTime.text = order.comment_time as String
        }
        return cell
    }
    

    
    @IBOutlet weak var CollectBtn: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var CommTableView: UITableView!
    @IBOutlet weak var Foodname: UILabel!
    @IBOutlet weak var FoodIn: UILabel!
    @IBOutlet weak var FoodPrice: UILabel!
    var shopPhoneNum : String = ""
    var food : NFFoodModel!
    var isCollect : NSString!
    var shop : NFShopModel!
    var user : NFUserModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        CommTableView.delegate = self
        CommTableView.dataSource = self
        self.title = food.foodname as String
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "CommList", bundle: nil)
        CommTableView.register(cellNib, forCellReuseIdentifier: "CommList")
        self.Foodname.text = "\(food.foodname!)"
        self.FoodPrice.text = "\(food.price!)元"
        self.FoodIn.text = "\(food.intro!)"
        //self.foodintro.text = "\(food.intro!)"
        let imageStr = food.pic
        let imageURL = URL(string: imageStr as! String)
        self.ImageView.setImageWith(imageURL, placeholderImage: UIImage(named:"placeHolder"))
        print(shopPhoneNum)
        self.isCollected()
        self.getCom()
//        NotificationCenter.default.addObserver(self, selector: #selector(NFFoodDetailViewController.makeOrder), name: NSNotification.Name(rawValue:"Order"), object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func makeOrder(){
//        self.performSegue(withIdentifier: "toFoodOrder", sender: food)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let orderController: NFFoodOrderViewController = segue.destination as! NFFoodOrderViewController
//        orderController.food = sender as! NFFoodModel
//    }
    
    
    
    //获取评论
    func getCom(){
        let parameters3: NSDictionary = ["food_id":self.food.food_id]
            as NSDictionary
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetFoodOrderListParameters(parameters3, view: self.view, block: {(orderList)->Void in
            self.orderList = orderList
            self.CommTableView.reloadData()
        })
    }

    @IBAction func CollectButton(_ sender: Any) {
            let parameters2: NSDictionary = ["user_id":userId,"food_id":self.food.food_id] as NSDictionary
            NFNetworkMngTool.sharedNetworkingTool().NFNetwork_CollectFoodWithParameters(parameters2, view: self.view) {(success) in
                if success == "1"{
                    self.isCollected()
                }else{
                    print("收藏/取消收藏失败")
                }
            }
        
    }
    
    
    func isCollected(){
        let parameters: NSDictionary = ["user_id":userId,"shop_food_id":self.food.food_id,"flag":1]
            as NSDictionary
        print(parameters)
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_isCollectedWithParameters(parameters, view: self.view) {
            (isCollect) in
            self.isCollect = isCollect
            if self.isCollect == "1" {
                self.CollectBtn.setImage(UIImage.init(named: "Favor.png"), for: UIControlState.normal)
                self.CollectBtn.setTitle("已收藏", for:UIControlState.normal)
            }else if self.isCollect == "0" {
                self.CollectBtn.setImage(UIImage.init(named: "cry.png"), for: UIControlState.normal)
                self.CollectBtn.setTitle("未收藏", for: UIControlState.normal)
            }
        }
    }
    
    @IBAction func Tel(_ sender: Any) {
//        if shop.phonenum != nil {
//            UIApplication.shared.openURL(URL(string: "telprompt://10086")!)
//        }
//        else{
//            let alertController = UIAlertController(title: "该商家没有电话号码!",
//                                                    message: nil, preferredStyle: .alert)
//            //显示提示框
//            self.present(alertController, animated: true, completion: nil)
//            //两秒钟后自动消失
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                self.presentedViewController?.dismiss(animated: false, completion: nil)
//            }
//        }
        UIApplication.shared.openURL(URL(string: "tel://\(shopPhoneNum)")!)
    }
    
    
    @IBAction func foodOrder(_ sender: Any) {
        
//        let OrderVC = NFFoodOrderViewController()
//        OrderVC.food = food
//        self.navigationController?.pushViewController(OrderVC, animated: true)
        self.performSegue(withIdentifier: "toOrderFood", sender: self)
        
    
        
        
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("receivef")
//
//        // segue.identifier：获取连线的ID
//        if (segue.identifier == "toOrderFood") {
//
//            if segue.identifier!.isEqual("toOrderFood") {
//
//                // segue.destinationViewController：获取连线时所指的界面（VC）
//                let receivef = segue.destination as! NFFoodOrderViewController;
//
//
//                receivef.foodName = food.foodname
//
//            }
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let foodOrderVC: NFFoodOrderViewController = segue.destination as! NFFoodOrderViewController
        //foodDetailCotroller.food = sender as! NFFoodModel
        foodOrderVC.foodName = food.foodname
        foodOrderVC.imgSrc = food.pic
        foodOrderVC.foodPrice = food.price
        foodOrderVC.foodid = food.food_id
        //foodDetailCotroller.shop = sender as! NFShopModel
        //controller.itemString = sender as? String
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
