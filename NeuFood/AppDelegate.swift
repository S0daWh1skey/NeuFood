//
//  AppDelegate.swift
//  NeuFood
//
//  Created by Albert Sphepherd on 2017/9/19.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //增加标识，用于判断是否是第一次启动应用...
        if (!(UserDefaults.standard.bool(forKey: "everLaunched"))) {
            UserDefaults.standard.set(true, forKey:"everLaunched")
            let guideViewController = GuideViewController()
            self.window!.rootViewController=guideViewController;
            print("guideview launched!")
        }
//        else{
//            let guideViewController = GuideViewController()
//            self.window!.rootViewController=guideViewController;
//            print("guideview launched!")
//        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}
