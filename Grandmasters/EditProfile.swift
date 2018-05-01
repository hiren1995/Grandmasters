//
//  EditProfile.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 17/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class EditProfile: UIViewController {
    
    var typeFlag = String()
    
    @IBOutlet weak var lblChangeHeader: UILabel!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLabelData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadLabelData()
    {
        if(typeFlag == "email")
        {
            lblFirst.text = "New Email Address"
            lblSecond.text = "Confirm Email Address"
            lblThird.text = "Password"
            
            txtThird.isSecureTextEntry = true
        }
        else
        {
            lblFirst.text = "Current Password"
            lblSecond.text = "New Password"
            lblThird.text = "Confirm Password"
            
            txtFirst.isSecureTextEntry = true
            txtSecond.isSecureTextEntry = true
            txtThird.isSecureTextEntry = true
        }
    }
    @IBAction func btnCancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if(typeFlag == "email")
        {
            if(txtFirst.text == "")
            {
                self.showAlert(title: "Alert", message: "Please Enter New Email")
            }
            else if(txtSecond.text == "")
            {
                self.showAlert(title: "Alert", message: "Please Enter Confirm Email")
            }
            else if(txtThird.text == "")
            {
                self.showAlert(title: "Alert", message: "Please Password")
            }
            else
            {
                if(txtFirst.text != txtSecond.text)
                {
                    self.showAlert(title: "Alert", message: "Please Enter Same New Email in Confirm Email")
                }
                else
                {
                    if !isValidEmail(testStr: txtFirst.text!)
                    {
                        self.showAlert(title: "Alert", message: "Please Enter vaild Email")
                    }
                    else
                    {
                        MBProgressHUD.showAdded(to: self.view, animated: true)
                        
                        let updateEmailParams:Parameters = ["userid": UserData["Mem_Id"].stringValue , "newemail": txtFirst.text! ,"password": txtThird.text!]
                        
                        Alamofire.request(updateEmailAPI, method: .get, parameters: updateEmailParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                            if(response.result.value != nil)
                            {
                                
                                
                                print(JSON(response.result.value))
                                
                                let temp = JSON(response.result.value)
                                
                                if(temp["message"].stringValue == "Success" && temp["response_code"].intValue == 200)
                                {
                                    UserData = temp["response_message"]["userdata"][0]
                                    MBProgressHUD.hide(for: self.view, animated: true)
                                    //self.showAlert(title: "Success", message: "Email Updated Successfully")
                                    
                                    //self.dismiss(animated: true, completion: nil)
                                    
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let signIn = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
                                    self.present(signIn, animated: true, completion: nil)
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
        }
        else
        {
            if(txtFirst.text == "")
            {
                self.showAlert(title: "Alert", message: "Please Enter Current Password")
            }
            else if(txtSecond.text == "")
            {
                self.showAlert(title: "Alert", message: "Please Enter New Password")
            }
            else if(txtThird.text == "")
            {
                self.showAlert(title: "Alert", message: "Please Enter Confirm Password")
            }
            else
            {
                if(txtThird.text != txtSecond.text)
                {
                    self.showAlert(title: "Alert", message: "Please Enter Same New Password and Confirm Password")
                }
                else
                {
                    
                        MBProgressHUD.showAdded(to: self.view, animated: true)
                        
                        let updatePasswdParams:Parameters = ["userid": UserData["Mem_Id"].stringValue , "newpassword": txtSecond.text! ,"oldpassword": txtFirst.text!]
                        
                        Alamofire.request(updatePasswordAPI, method: .get, parameters: updatePasswdParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                            if(response.result.value != nil)
                            {
                                
                                
                                print(JSON(response.result.value))
                                
                                let temp = JSON(response.result.value)
                                
                                if(temp["message"].stringValue == "Success" && temp["response_code"].intValue == 200)
                                {
                                    UserData = temp["response_message"]["userdata"][0]
                                    MBProgressHUD.hide(for: self.view, animated: true)
                                    //self.showAlert(title: "Success", message: "Email Updated Successfully")
                                    
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let signIn = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
                                    self.present(signIn, animated: true, completion: nil)
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
