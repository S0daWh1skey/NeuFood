//
//  LoginViewController.swift
//  NeuFood
//
//  Created by Albert Sphepherd on 2017/9/21.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

//
//  LoginViewController.swift
//  AmiCool-Redo
//
//  Created by Albert Sphepherd on 2017/6/3.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var LoginBt: UIButton!
    
    @IBOutlet weak var UserPic: UIImageView!
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    //var haveSucceedLogin = 0
    @IBAction func Login(_ sender: Any) {
        if self.Username.text?.characters.count == 0{
            //pompAlert(message: "没有输入用户名")
            MBProgressHUD.showDelayHUDToView(self.view, message: "没有输入用户名")
        }
        else if  self.Password.text?.characters.count == 0{
            //pompAlert(message: "没有输入密码")
            MBProgressHUD.showDelayHUDToView(self.view, message: "没有输入密码")
        }
            
        else {
            let parameters = ["username":self.Username.text!,
                              "userpass":self.Password.text!]

            //request
            
//            NFNetworkMngTool.shared.NFNetwork_Login(parameters as NSDictionary , block: { (flag) in
//                if flag == "1"{
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:
//                        {   //self.pompAlert(message: "登录成功")
//                            UserDefaults.standard.set(true, forKey: "login")
//                            let _ = (ACSimpleKeychain.defaultKeychain() as AnyObject).storeUsername(self.Username.text, password: self.Password.text, identifier: "user1", forService: "userpassword")
//                            UIApplication.shared.keyWindow!.rootViewController = NeuFoodMainTabbarViewController()
//
//                    })
//                }
//                else{
//                    //self.pompAlert(message: "登录不成功"）
//                    MBProgressHUD.showDelayHUDToView(self.view, message: "登录不成功")
//                }
//
//            })
            NFNetworkMngTool.sharedNetworkingTool().NFNetwor_Logon(parameters as NSDictionary, view: self.view, block: { (flag:NSString) in
                if flag != "0"{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:{
                    MBProgressHUD.showDelayHUDToView(self.view, message: "登陆成功")
                    UserDefaults.standard.set(true, forKey: "login")
                    let _ = (ACSimpleKeychain.defaultKeychain() as AnyObject).storeUsername(self.Username.text, password: self.Password.text, identifier: "user1", forService: "userpassword")
                        UIApplication.shared.keyWindow!.rootViewController = NeuFoodMainTabbarViewController()
                    })
                }else{
                    MBProgressHUD.showDelayHUDToView(self.view, message: "登录不成功")
                }
            })

        }
        
    }
    
    
    
    func pompAlert(message:String){
        let alert = UIAlertController(title: "提示", message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.Username.resignFirstResponder()
        self.Password.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.UserPic.image = UIImage(named: "Others/bgimage.JPG")
        self.LoginBt.layer.cornerRadius = 9.0
        //self.view.backgroundColor = UIColor.clear
        if (UserDefaults.standard.bool(forKey: "login")==true){
        featchUserNamePwd()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //封装函数取用户名和密码
    func featchUserNamePwd(){
        let userPwdDict = (ACSimpleKeychain.defaultKeychain() as AnyObject).credentials(forIdentifier: "user1", service: "userpassword") as NSDictionary
        if userPwdDict.count != 0 {
            Username.text = userPwdDict.object(forKey: "username") as? String
            Password.text = userPwdDict["password"] as? String
        }
    }

    @IBAction func Exit(_ sender: Any) {
        Password.resignFirstResponder();
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
