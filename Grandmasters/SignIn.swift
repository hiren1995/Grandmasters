//
//  SignIn.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 13/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit

var UserData = JSON()

class SignIn: UIViewController,UITextFieldDelegate {
    
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var ViewForgetPassword: UIView!
    @IBOutlet weak var lblForgetPasswd: UILabel!
    @IBOutlet weak var txtEmailFP: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.delegate = self
        txtPassword.delegate = self
        txtEmail.returnKeyType = .done
        txtPassword.returnKeyType = .done
        addDoneButtonOnKeyboard()
        ViewForgetPassword.isHidden = true
        
        lblForgetPasswd.setTopRoundCorners(radius : 10)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnForgetPassword(_ sender: UIButton) {
        
        ViewForgetPassword.isHidden = false
    }
    
    @IBAction func btnEnter(_ sender: UIButton) {
        
        if(txtEmail.text == "")
        {
            self.showAlert(title: "Alert", message: "Enter Email")
        }
        else if(txtPassword.text == "")
        {
            self.showAlert(title: "Alert", message: "Enter Password")
        }
        else
        {
            if !isValidEmail(testStr: txtEmail.text!)
            {
                self.showAlert(title: "Alert", message: "Please Enter Vaild Email")
            }
            else
            {
                let params:Parameters = ["email" : txtEmail.text! ,"pwd" : txtPassword.text! , "GcmId" : userDefault.value(forKey: DeviceToken)!,"deviceid" : userDefault.value(forKey: DeviceId) as! String, "Mem_DeviceType" : 2]

                
                loginCall(LoginParams: params)
                
            }
        }
    }
    
    
    @IBAction func btnRegister(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUp = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignUp
        self.present(signUp, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func addDoneButtonOnKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(cancelKeyboard))
        
        var items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as! [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        txtPassword.inputAccessoryView = doneToolbar
        txtEmail.inputAccessoryView = doneToolbar
        txtEmailFP.inputAccessoryView = doneToolbar
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    @IBAction func txtPasswordDidBegin(_ sender: UITextField) {
        
        self.view.frame.origin.y =  self.view.frame.origin.y - 50
    }
    
    @IBAction func txtPasswordDidEnd(_ sender: UITextField) {
        
        self.view.frame.origin.y =  self.view.frame.origin.y + 50
    }
    @IBAction func txtEmailFPbegin(_ sender: UITextField)
    {
        ViewForgetPassword.frame.origin.y = ViewForgetPassword.frame.origin.y - 50
    }
    @IBAction func txtEmailFPend(_ sender: UITextField) {
        
        ViewForgetPassword.frame.origin.y = ViewForgetPassword.frame.origin.y + 50
    }
    
    @IBAction func btnSendPasswd(_ sender: UIButton) {
        
        if (txtEmailFP.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Email")
        }
        else
        {
            if !isValidEmail(testStr: txtEmailFP.text!)
            {
                self.showAlert(title: "Alert", message: "Please Enter valid Email")
            }
            else
            {
                
                MBProgressHUD.showAdded(to: self.view, animated: true)
                
                let forgetPasswdParams:Parameters = ["emailid": txtEmailFP.text!]
                
                Alamofire.request(forgetPasswordAPI, method: .get, parameters: forgetPasswdParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    if(response.result.value != nil)
                    {
                        
                        
                        print(JSON(response.result.value))
                        
                        let temp = JSON(response.result.value)
                        
                        if(temp["message"].stringValue == "Success" && temp["response_code"].intValue == 200)
                        {
                            
                            MBProgressHUD.hide(for: self.view, animated: true)
                            
                            
                            self.ViewForgetPassword.isHidden = true
                            
                        }
                        else if(temp["response_code"].intValue == 404)
                        {
                            self.showAlert(title: "Alert", message: temp["response_message"].stringValue)
                        }
                        else
                        {
                            MBProgressHUD.hide(for: self.view, animated: true)
                            self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                        }
                        
                    }
                    else
                    {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print("Error in Getting Response")
                        self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                    }
                })
                
                
            }
        }
        
    }
    
    @IBAction func BtnFBLogin(_ sender: UIButton) {
        
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile","user_friends"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                print(result)
                
                // if user cancel the login
                if (result?.isCancelled)!{
                    
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email")){
                    if((FBSDKAccessToken.current()) != nil){
                        
                        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                            if (error == nil){
                                //everything works print the user data
                                //print(FBSDKAccessToken.current().tokenString)
                                
                                let FBinfo = JSON(result)
                                print(FBinfo)
                                
                                let params:Parameters = ["email" : FBinfo["email"].stringValue , "deviceid" : userDefault.value(forKey: DeviceId) as! String , "GcmId" : userDefault.value(forKey: DeviceToken)! , "fbid" : FBinfo["id"].intValue , "name" : FBinfo["name"].stringValue , "fname" : FBinfo["first_name"].stringValue , "lname" : FBinfo["last_name"].stringValue , "propic" : FBinfo["picture"]["data"]["url"].stringValue , "Mem_DeviceType" : 2]
                                
                                self.loginCall(LoginParams: params)
                               
                            }
                        })
                        
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        ViewForgetPassword.isHidden = true
    }
    
    func loginCall(LoginParams : Parameters)
    {
       
        userDefault.set(LoginParams, forKey: loginParam)
        
        print(LoginParams)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Alamofire.request(UserLoginAPI, method: .get, parameters: LoginParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                print(JSON(response.result.value))
                
                let temp = JSON(response.result.value)
                
                if(temp["message"] == "Success")
                {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    userDefault.set(true, forKey: isLogin)
                    
                    userDefault.set(temp["response_message"]["userid"].intValue, forKey: UserId)
                    
                    UserData = temp["response_message"]["userdata"][0]
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
                    self.present(dashboard, animated: true, completion: nil)
                    
                }
                else
                {
                     MBProgressHUD.hide(for: self.view, animated: true)
                    self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                }
                
            }
            else
            {
                 MBProgressHUD.hide(for: self.view, animated: true)
                print("Error in Getting Response")
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
        
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
