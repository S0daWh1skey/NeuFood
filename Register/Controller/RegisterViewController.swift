//
//  RegisterViewController.swift
//  NeuFood
//
//  Created by Albert Sphepherd on 2017/9/23.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var RegBt: UIButton!
    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passWordText: UITextField!
    
    @IBOutlet weak var rePasswordText: UITextField!
    
    @IBOutlet weak var PhoneNumber: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var comments: UITextField!
    
    // var lc = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.RegBt.layer.cornerRadius = 9.0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Register(_ sender: Any) {
        if self.userNameText.text?.characters.count == 0{
            pompAlert(message: "没有输入用户名")
        }
        else if self.passWordText.text?.characters.count == 0{
            pompAlert(message: "没有输入密码")
        }
        else if self.rePasswordText.text?.characters.count == 0{
            pompAlert(message: "没有重新输入密码")
        }
        else if self.PhoneNumber.text?.characters.count == 0{
            pompAlert(message: "请输入手机号")
        }
        else if self.address.text?.characters.count == 0{
            pompAlert(message: "请输入地址")
        }
        else if self.comments.text?.characters.count == 0{
            pompAlert(message: "请输入你的身份")
        }
        else if self.passWordText.text! != self.rePasswordText.text!{
            pompAlert(message: "两次输入的密码不同")
            self.passWordText.text = ""
            self.rePasswordText.text = ""
        }
        else{
            let parameters = [
                "username":self.userNameText.text!,
                "userpass":self.passWordText.text!,
                "mobilenum":self.PhoneNumber.text!,
                "address":self.address.text!,
                "comment":self.comments.text!
            ]
            //request
            NFNetworkMngTool.shared.NFNetwork_Login(parameters as NSDictionary , block: { (flag) in
                if flag == "1"{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute:
                        {   let alertController = UIAlertController(title: "系统提示", message:  "注册成功", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "去登录", style: .default, handler: {
                                action in
                                self.presentingViewController!.dismiss(animated: true, completion: nil)
                            })
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                    })
                }
                else{
                    self.pompAlert(message: "注册不成功")
                }
                
            })
            
            //self.presentingViewController!.dismiss(animated: true, completion: nil)
            
        }
        
    }
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userNameText.resignFirstResponder()
        self.passWordText.resignFirstResponder()
        self.rePasswordText.resignFirstResponder()
        self.PhoneNumber.resignFirstResponder()
        self.address.resignFirstResponder()
        self.comments.resignFirstResponder()
        return true
    }
    
    func pompAlert(message:String){
        let alert = UIAlertController(title: "提示", message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        self.Username.resignFirstResponder()
    //        self.Password.resignFirstResponder()
    //        return true
    //    }
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        self.Username.resignFirstResponder()
    //        self.Password.resignFirstResponder()
    //        return true
    //    }
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        self.Username.resignFirstResponder()
    //        self.Password.resignFirstResponder()
    //        return true
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

