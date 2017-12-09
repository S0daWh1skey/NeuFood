//
//  CollectionViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/16.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class CollectionViewController: UITableViewController {
    var shopId: NSNumber!
    var shopName: NSString!
    @IBAction func DoSegemet(_ sender: UISegmentedControl) {
        print(Segemet.selectedSegmentIndex)
        if(Segemet.selectedSegmentIndex == 0){
            GetCollectionShop()
        }
        else{
            GetCollectionFood()
        }
    }
    
    @IBOutlet weak var Segemet: UISegmentedControl!
    
    var collectionList: NSArray = NSArray()
    
    override func viewDidLoad() {
       // print(Segemet.selectedSegmentIndex)
        super.viewDidLoad()
        let parameters: NSDictionary = ["user_id":userId,"flag":0]
            as NSDictionary
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserCollectionShop(parameters, view: self.view) { (CollectionList:NSArray) in
            self.collectionList = CollectionList
            self.tableView.reloadData()
        }
        
        
//        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetShopListView(self.view) { (CollectionList:NSArray) in
//
//            self.collectionList = CollectionList
//            self.tableView.reloadData()
//
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func GetCollectionShop(){
        let parameters: NSDictionary = ["user_id":userId,"flag":0]
            as NSDictionary
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserCollectionShop(parameters, view: self.view) { (CollectionList:NSArray) in
            self.collectionList = CollectionList
            self.tableView.reloadData()
        }
    }
    
    
    func GetCollectionFood(){
        let parameters1: NSDictionary = ["user_id":userId,"flag":1]
            as NSDictionary
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserCollectionShop(parameters1, view: self.view) { (CollectionList:NSArray) in
            self.collectionList = CollectionList
            self.tableView.reloadData()
        }
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
        if self.collectionList.count == 0{
            return 0
        }
        
        return self.collectionList.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let currentShop: NFShopModel = shopList[(indexPath as NSIndexPath).row] as! NFShopModel
//        self.performSegue(withIdentifier: "toFoodList", sender: currentShop)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let foodListController:
//            NFFoodListTableViewController =
//            segue.destination as!
//        NFFoodListTableViewController
//        
//        foodListController.shop = sender as! NFShopModel
//    }
//    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath)
        // Configure the cell...
        if self.collectionList.count != 0 {
            let Collectionshop: NFCShopModel = self.collectionList[(indexPath as NSIndexPath).row] as! NFCShopModel
            if(Segemet.selectedSegmentIndex == 0){
            cell.textLabel!.text = Collectionshop.shopname as String
            }
            else{
                cell.textLabel!.text = Collectionshop.foodname as String
            }
            //使用afnetworking中的uiimageview加载网络图片
            let imageStr = Collectionshop.pic as String
            let imageUrl = URL(string: imageStr)
            cell.imageView!.setImageWith(imageUrl, placeholderImage: UIImage(named:
                "placeHolder"))
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(Segemet.selectedSegmentIndex == 0){
        let currentShop: NFCShopModel = collectionList[(indexPath as NSIndexPath).row] as! NFCShopModel
        self.performSegue(withIdentifier: "toFoodList", sender: currentShop)
        }
        else{
            let currentShop: NFCShopModel = collectionList[(indexPath as NSIndexPath).row] as! NFCShopModel
            self.performSegue(withIdentifier: "toFoodDetail1", sender: currentShop)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(Segemet.selectedSegmentIndex == 0){
            let foodListController:
                CFoodListTableViewController =
                segue.destination as!
            CFoodListTableViewController
            //        print(shopId)
            //        foodListController.shopId = shopId
            //        foodListController.shopName = shopName
            foodListController.shop = sender as! NFCShopModel
        }
    }
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

