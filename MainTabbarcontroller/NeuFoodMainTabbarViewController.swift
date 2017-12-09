//
//  NeuFoodMainTabbarViewController.swift
//  NeuFood
//
//  Created by Albert Sphepherd on 2017/10/12.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class NeuFoodMainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let firstViewController = UIViewController()
//        firstViewController.title = "首页"
//        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let homePageStoryBoard:UIStoryboard = UIStoryboard(name: "homepage", bundle: nil)
        let homePageNavgationController:UIViewController = homePageStoryBoard.instantiateViewController(withIdentifier: "homePageNav")
        
        let MeStoryBoard:UIStoryboard = UIStoryboard(name: "Me", bundle: nil)
        let MepageNavgationController:UIViewController = MeStoryBoard.instantiateViewController(withIdentifier: "mePageNav")
        //let MePageController:UIViewController = MeStoryBoard.instantiateViewController(withIdentifier: "Me")
        
        let SearchStoryBoard:UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let SearchNavgationController:UIViewController = SearchStoryBoard.instantiateViewController(withIdentifier: "searchNav")
        
        let CollectionStoryBoard:UIStoryboard = UIStoryboard(name: "Collection", bundle: nil)
        let CollectionPageNavgationController:UIViewController = CollectionStoryBoard.instantiateViewController(withIdentifier: "CollectionNav")
        //let CollectionPageController:UIViewController = CollectionStoryBoard.instantiateViewController(withIdentifier: "Collection")
        
        
//        let secondViewController = UIViewController()
//        secondViewController.title = "收藏"
//        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
//        let thirdViewController = UIViewController()
//        thirdViewController.title = "搜索"
//        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)
//        let fourthViewController = UIViewController()
//        fourthViewController.title = "我"
//        let fourthNavigationController = UINavigationController(rootViewController: fourthViewController)
         self.viewControllers = [homePageNavgationController,CollectionPageNavgationController,SearchNavgationController,MepageNavgationController]
        // Set tabBar
        let tabBar = self.tabBar
        self.tabBar.frame = CGRect(x: tabBar.frame.minX, y: tabBar.frame.minY, width: tabBar.frame.width, height: 40)
        
        let tabBarItemTitles:[String] = ["首页","收藏","搜索","我"]
        let tabBarItemImages:[String] = ["Index","Favor","Search","Me"]
        var index = 0
        for item in self.tabBar.items!{
            //设置标题
            item.title = tabBarItemTitles[index]
            //Set Icon
            let selectedImage = UIImage(named: String(format: "%@-2.png",tabBarItemImages[index]))
            //print(String(format: "images/%@.png",tabBarItemImages[index]))
            let unselsectedImage = UIImage(named: String(format: "%@.png",tabBarItemImages[index]))
            item.image = selectedImage
            item.selectedImage = unselsectedImage
            index += 1
        }
        
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

}
