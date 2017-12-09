//
//  MeViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/9.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class MeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.orderList.count == 0{
            return 0
        }
        return self.orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "OrderedCell", for: indexPath)
        let cell: UserOrderedTableViewCell = self.OrderedTableView.dequeueReusableCell(withIdentifier: "OrderedCell") as! UserOrderedTableViewCell
        if self.Segment.selectedSegmentIndex == 0 {
            if self.orderList.count != 0{
                let order: NFOrderModel = self.orderList[(indexPath as NSIndexPath).row] as! NFOrderModel
                cell.FoodName.text = order.foodname as String
                cell.OrderedTime.text = order.ordertime as String
                //self.OrderedTableView.reloadData()
            }
        }
        if self.Segment.selectedSegmentIndex == 1{
            if self.orderList.count != 0{
                let order: NFOrderModel = self.orderList[(indexPath as NSIndexPath).row] as! NFOrderModel
                cell.FoodName.text = order.content as String
                cell.OrderedTime.text = order.comment_time as String
                //self.OrderedTableView.reloadData()
            }
        }
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if self.Segment.selectedSegmentIndex == 0 {
        let currentOrder: NFOrderModel = orderList[(indexPath as NSIndexPath).row] as! NFOrderModel
        self.performSegue(withIdentifier: "toComment", sender: currentOrder)
        }
        if self.Segment.selectedSegmentIndex == 1{
            let currentOrder: NFOrderModel = orderList[(indexPath as NSIndexPath).row] as! NFOrderModel
            self.performSegue(withIdentifier: "toEditComment", sender: currentOrder)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if self.Segment.selectedSegmentIndex == 0 {
        let AddCommentController : CommentViewController = segue.destination as! CommentViewController
        AddCommentController.Order = sender as! NFOrderModel
        }
        if self.Segment.selectedSegmentIndex == 1{
            let EditCommentController : EditCommentViewController = segue.destination as! EditCommentViewController
            EditCommentController.Order = sender as! NFOrderModel
        }
        
        
    }
    
    
    var orderList:NSArray = NSArray()
    var userDict:NSDictionary = NSDictionary()
    var user : NFUserModel!
    @IBOutlet weak var UserPhoneNumber: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Segment: UISegmentedControl!
    @IBOutlet weak var OrderedTableView: UITableView!
    @IBOutlet weak var Pic: UIImageView!
    override func viewDidLoad() {
        self.Segment.selectedSegmentIndex = 0
        super.viewDidLoad()
        let cellNib = UINib(nibName: "OrderedCell", bundle: nil)
        OrderedTableView.register(cellNib, forCellReuseIdentifier: "OrderedCell")
        OrderedTableView.dataSource = self
        OrderedTableView.delegate = self
        // Do any additional setup after loading the view.
        self.Pic.contentMode = .scaleAspectFill
        self.Pic.layer.masksToBounds = true
        self.Pic.layer.cornerRadius = self.Pic.frame.width/2
        getUserInfo()
        self.getUerOrder()
    }
    func getUserInfo(){
        let parameters: NSDictionary = ["user_id": userId]
            as NSDictionary
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserById(parameters, view: self.view) { (userDict) in
            self.userDict = userDict
            print(userDict)
            let username = userDict.value(forKey: "username") as! String
            let userPhoneNum = userDict.value(forKey: "mobilenum") as! String
            print(username)
            self.UserName.text = username
            self.UserPhoneNumber.text = userPhoneNum
        }
    }
    
    
    
    @IBAction func DoSegment(_ sender: UISegmentedControl) {
        print(Segment.selectedSegmentIndex)
        if(Segment.selectedSegmentIndex == 0){
            getUerOrder()
        }
        else{
            getUerComm()
        }
    }
    
    func getUerOrder(){
        let parameters2: NSDictionary = ["user_id": userId]
            as NSDictionary
        print(parameters2)
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserOrderListParameters(parameters2, view: self.view, block: {(orderList)->Void in
            self.orderList = orderList
            self.OrderedTableView.reloadData()
        })
    }
    
    func getUerComm(){
        let parameters2: NSDictionary = ["user_id": userId]
            as NSDictionary
        print(parameters2)
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserCommListParameters(parameters2, view: self.view, block: {(orderList)->Void in
            self.orderList = orderList
            self.OrderedTableView.reloadData()
        })
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController? .setNavigationBarHidden(true, animated: true)
    }
    
}

