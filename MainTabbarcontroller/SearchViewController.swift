//
//  SearchViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/16.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController{
    var searchtext:String = ""
    @IBOutlet weak var SearchText: UITextField!
    var foodList:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "searched") == true {
            self.searchtext = UserDefaults.standard.string(forKey: "text")! as String
            doSearch()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func Search(_ sender: Any) {
        //print(SearchText.text!)
        searchtext=SearchText.text!
        //print(searchtext)
        //let utf8Str = str.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        doSearch()
        SearchText.resignFirstResponder()
    }
    
    
    func doSearch(){
        let parameters = ["search": self.searchtext]
        //print(parameters)
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetSearchResult(parameters as NSDictionary, view: self.view, block: {(foodList)->Void in
            self.foodList = foodList
            UserDefaults.standard.set(true, forKey: "searched")
            UserDefaults.standard.set(self.searchtext, forKey: "text")
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.foodList.count == 0{
            return 0
        }
        else{
            return self.foodList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
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
    
}

