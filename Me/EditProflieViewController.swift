//
//  EditProflieViewController.swift
//  NeuFood
//
//  Created by Albert Shepherd on 2017/11/14.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit
class EditProflieViewController: UIViewController {
    
    
    var userDict:NSDictionary = NSDictionary()
    var user : NFUserModel!
    var Cusername:String = ""
    var Cpwd:String = ""
    var Cphonenum:String = ""
    var Cadd:String = ""
    var Userpwd = ""
    var username:String = ""
    var userPhoneNum:String = ""
    var userid:String = ""
    var userAdd:String = ""
    @IBOutlet weak var Btn: UIButton!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var PhoneNum: UITextField!
    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Pwd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Btn.layer.cornerRadius = 9.0
        // Do any additional setup after loading the view.
        //ChangeUserInfo()
        GetUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetUserInfo(){
        let parameters: NSDictionary = ["user_id": userId]
            as NSDictionary
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserById(parameters, view: self.view) { (userDict) in
            self.userDict = userDict
            //print(userDict)
            self.username = userDict.value(forKey: "username") as! String
            self.userPhoneNum = userDict.value(forKey: "mobilenum") as! String
            print(self.username)
            self.userid = userId as String
            //self.UserName.text = username
            //self.UserPhoneNumber.text = userPhoneNum
            self.userAdd = userDict.value(forKeyPath: "address") as! String
            print(self.userAdd,self.userPhoneNum,self.username,self.userid)
        }
    }
    
    
    
    func ChangeUserInfo(){
        let userPwdDict = (ACSimpleKeychain.defaultKeychain() as AnyObject).credentials(forIdentifier: "user1", service: "userpassword") as NSDictionary
        if userPwdDict.count != 0 {
            self.Userpwd = (userPwdDict.object(forKey: "password") as? String)!
            //print(Userpwd)
        }//获取用户密码
//        let parameters: NSDictionary = ["user_id": userId]
//            as NSDictionary
//        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_GetUserById(parameters, view: self.view) { (userDict) in
//            self.userDict = userDict
//            //print(userDict)
//            self.username = userDict.value(forKey: "username") as! String
//            self.userPhoneNum = userDict.value(forKey: "mobilenum") as! String
//            print(self.username)
//            self.userid = userId as String
//            //self.UserName.text = username
//            //self.UserPhoneNumber.text = userPhoneNum
//            self.userAdd = userDict.value(forKeyPath: "address") as! String
//            print(self.userAdd,self.userPhoneNum,self.username,self.userid)
//        }
        let tempuserName = self.Uname.text
        let temppwd = self.Pwd.text
        let tempphoneNum = self.PhoneNum.text
        let tempadd = self.Address.text
//        if(tempuserName == ""){
//            self.Cusername = username
//            }
//        if(temppwd == ""){
//            self.Cpwd = Userpwd
//            //print(Cpwd)
//        }
//        if(tempphoneNum == ""){
//            self.Cphonenum = userPhoneNum
//        }
//        if(tempadd == ""){
//            self.Cadd = userAdd
//        }
        if(tempuserName == username){
            self.Cusername = username
        }//判断用户是否改变
        else{
            //self.Cusername = tempuserName!
            if(tempuserName == ""){
                self.Cusername = username
            }
            else{
                self.Cusername = tempuserName!
            }
        }
        if(temppwd == self.Userpwd){
            self.Cpwd = self.Userpwd
        }//判断密码是否改变
        else{
            //self.Cpwd = temppwd!
            if(tempuserName == ""){
                self.Cpwd = Userpwd
            }
            else{
                self.Cpwd = temppwd!
            }
        }
        if(tempphoneNum == userPhoneNum){
            self.Cphonenum = self.userPhoneNum
        }//判断手机号是否改变
        else{
            //self.Cphonenum = tempphoneNum!
            if(tempphoneNum == ""){
                self.Cphonenum = userPhoneNum
            }
            else{
                self.Cphonenum = tempphoneNum!
            }
        }
        if(tempadd == self.userAdd){
            self.Cadd = self.userAdd
        }
        else{
            //self.Cadd = tempadd!
            if(Cadd == ""){
                self.Cadd = userAdd
            }
            else{
                self.Cadd = tempadd!
            }
        }
        if(Cadd != ""){
        print("用户id:\(userId)  用户名:\(Cusername) 用户密码：\(Cpwd) 用户手机号:\(Cphonenum) 用户地址:\(Cadd)")
        
        let  parameters1 = ["user_id":userId,
                          "userpass":Cpwd,
                          "username":Cusername,
                          "mobilenum":Cphonenum,
                          "address":Cadd] as [String : Any]
        print(parameters1)
        NFNetworkMngTool.sharedNetworkingTool().NFNetwork_UpdateInfo(parameters1 as NSDictionary, view: self.view) {(success) in
            if success == "1"{
                let alertController = UIAlertController(title: "修改成功!",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            }else{
                print("修改失败")
            }
        }
        }
    }

    @IBAction func ChangeInfo(_ sender: UIButton) {
        ChangeUserInfo()
        //ChangeUserInfo()
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
        self.navigationController? .setNavigationBarHidden(false, animated: true)
    }

}
