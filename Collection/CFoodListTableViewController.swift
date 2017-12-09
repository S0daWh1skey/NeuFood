//
//  CFoodListTableViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/26.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class CFoodListTableViewController: UITableViewController {
    var shopId: NSNumber!
    var shopName: NSString!
    var foodList:NSArray = NSArray()
    var shop: NFCShopModel!{
        didSet(oldvalue){
            shopId = shop.shop_id
            shopName = shop.shopname
        }
    }
    
    //var rightBtn : UIButton = UIButton.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.isNavigationBarHidden = false
//        rightBtn.sizeToFit()
//        rightBtn.addTarget(self, action: #selector(collectionShop), for: UIControlEvents.touchUpInside)
//        collectionBarBtnItem = UIBarButtonItem.init(customView:rightBtn)
//        self.navigationItem.rightBarButtonItem = collectionBarBtnItem
        
        self.title = self.shopName as String?
        print(shopId)
        let parameters: NSDictionary = ["shop_id": self.shopId]
            as NSDictionary
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetFoodListParameters(parameters, view: self.view, block: {(foodList)->Void in
            self.foodList = foodList
            self.tableView.reloadData()
        })

        
//        let parameters: NSDictionary = ["shop_id": shopId]
//            as NSDictionary
//        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetFoodListParameters(parameters, view: self.view, block: {(foodList)->Void in
//            self.foodList = foodList
//            self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.foodList.count == 0{
            return 0
        }
        return self.foodList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        // Configure the cell...
        if self.foodList.count != 0{
            let food: NFFoodModel = self.foodList[(indexPath as NSIndexPath).row] as! NFFoodModel
            cell.textLabel!.text = food.foodname as String
            //使用AFNetworking中的UIImageView加载网络图片
            let imgStr = food.pic as String
            let imgUrl = URL(string: imgStr)
            cell.imageView!.setImageWith(imgUrl, placeholderImage: UIImage(named: "placeHolder"))
            
            cell.accessoryType =
                UITableViewCellAccessoryType.disclosureIndicator
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFood: NFFoodModel = foodList[(indexPath as NSIndexPath).row] as! NFFoodModel
        self.performSegue(withIdentifier: "toFoodDetail", sender: currentFood)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let foodDetailCotroller: NFFoodDetailViewController = segue.destination as! NFFoodDetailViewController
        foodDetailCotroller.food = sender as! NFFoodModel
        //foodDetailCotroller.shopPhoneNum = shop.phonenum! as String
        //foodDetailCotroller.shop = sender as! NFShopModel
        //controller.itemString = sender as? String
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
