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

var UserData = JSON()


class SignIn: UIViewController,UITextFieldDelegate {

    
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
        
        //lblForgetPasswd.setTopRoundCorners(radius : 10)
        
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
                
                
                let urlString = UserLoginAPI + "email=" +  "\(String(describing: txtEmail.text!))" + "&pwd=" + "\(String(describing: txtPassword.text!))" + "&GcmId=" + "123456"
                
                print(urlString)
                
                
                
                Alamofire.request(urlString).responseJSON { response in
                    
                    print(JSON(response.result.value))
                    
                    let temp = JSON(response.result.value)
                    
                    if(temp["message"] == "Success")
                    {
                        
                            userDefault.set(temp["response_message"]["userid"].intValue, forKey: UserId)
                            UserData = temp["response_message"]["userdata"][0]
                        
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
                            self.present(dashboard, animated: true, completion: nil)
                        
                        
                    }
                    else
                    {
                        
                        self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                    }
                }
               
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
                
                ViewForgetPassword.isHidden = true
            }
        }
        
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        ViewForgetPassword.isHidden = true
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
