//
//  NFFoodDetailTableViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/2.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit
class NFFoodDetailTableViewController: UITableViewController {
    var food : NFFoodModel!
    override func viewDidLoad() {
        self.title = food.foodname as! String
        super.viewDidLoad()
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
        return 1
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if((indexPath as NSIndexPath).row == 0){
            return CELLHEIGHT
        }
        else if ((indexPath as NSIndexPath).row == 1)
        {
            return CELLHEIGHT
        }
        else{
            return 60
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "foodHeaderCell", for: indexPath)
        var basecell: UITableViewCell = UITableViewCell()
        if(indexPath as NSIndexPath).row == 0 {
            let cell : NFFoodHeaderCell = tableView.dequeueReusableCell(withIdentifier: "foodHeaderCell", for: indexPath) as! NFFoodHeaderCell
            cell.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CELLHEIGHT);
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine;
            
            let imageStr = food.pic
            let imageURL = URL(string: imageStr as! String)
            
            cell.foodImageView!.setImageWith(imageURL, placeholderImage: UIImage(named:"placeHolder"))
            
            cell.foodName.text = food.foodname as! String
            
            cell.price.text = "\(food.price!)元"
            
            cell.recommand.text = "\(food.recommand!)"

            cell.shop_id.text = "\(food.shop_id!)"
            basecell = cell
        }

        

        return basecell
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
