//
//  ShoListTableViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/10/24.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class ShoListTableViewController: UITableViewController {

    var shopList: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let cellNib = UINib(nibName: "ShopCell", bundle: nil)
//        tableView.register(cellNib, forCellReuseIdentifier: "ShopCell")
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetShopListView(self.view) { (ShopList:NSArray) in
            
            self.shopList = ShopList
            self.tableView.reloadData()
            
        }
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
        if self.shopList.count == 0{
            return 0
        }
        
        return self.shopList.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentShop: NFShopModel = shopList[(indexPath as NSIndexPath).row] as! NFShopModel
        self.performSegue(withIdentifier: "toFoodList", sender: currentShop)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let foodListController:
        NFFoodListTableViewController =
        segue.destination as!
        NFFoodListTableViewController
        
        foodListController.shop = sender as! NFShopModel
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath)
//        let cell: NFShopTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ShopCell") as! NFShopTableViewCell
        // Configure the cell...
        if self.shopList.count != 0 {
            let shop: NFShopModel = self.shopList[(indexPath as NSIndexPath).row] as! NFShopModel
            //使用afnetworking中的uiimageview加载网络图片
            cell.textLabel?.text = shop.shopname as String
            let imageStr = shop.pic as String
            let imageUrl = URL(string: imageStr)
            //cell.imageView!.setImageWith(imageUrl, placeholderImage: UIImage(named:"placeHolder"))
            cell.imageView!.setImageWith(imageUrl, placeholderImage: UIImage(named:"placeHolder"))
//            cell.ShopName.text = shop.shopname as String
//            cell.ShopIntro.text = shop.intro as String
//            cell.ShopAddress.text = shop.address as String
//            cell.ShopLevel.text = shop.level as String
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        return cell
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
