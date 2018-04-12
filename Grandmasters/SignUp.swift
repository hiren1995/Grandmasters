//
//  SignUp.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 14/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import CountryPicker
import Alamofire
import SwiftyJSON


var isAgree:Bool = false
var Country = String()
var CountryCode = String()

class SignUp: UIViewController,CountryPickerDelegate{
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtConfirmEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var txtFightersName: UITextField!
    
    @IBOutlet weak var lblSelectCountry: UILabel!
    
    @IBOutlet weak var picker: CountryPicker!
    
    @IBOutlet weak var imgAgree: UIImageView!
    
    @IBOutlet weak var btnClosePicker: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgFlag.isHidden = true
        lblCountryName.isHidden = true
        picker.isHidden = true
        btnClosePicker.isHidden = true
        
        PickerConfiguration()
        
        addDoneButtonOnKeyboard()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSelectCountry(_ sender: UIButton) {
        
        imgFlag.isHidden = false
        lblCountryName.isHidden = false
        lblSelectCountry.isHidden = true
        
        btnClosePicker.isHidden = false
        picker.isHidden = false
    }
    
    @IBAction func btnCreateFighter(_ sender: UIButton) {
        
        if(txtEmail.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Email")
        }
        else if(txtConfirmEmail.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Confirm Email")
        }
        else if(txtPassword.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Password")
        }
        else if(txtFightersName.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Fighter Name")
        }
        else if(txtConfirmEmail.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Confirm Password")
        }
        else if(lblCountryName.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Select your Country")
        }
        else if(imgAgree.image != UIImage(named: "ic_cb_checked"))
        {
            self.showAlert(title: "Alert", message: "Please Agree to Terms and Conditions of Grandmasters")
        }
        else
        {
            if(txtEmail.text != txtConfirmEmail.text){
                
                self.showAlert(title: "Alert", message: "Please Enter correct Confirm Email")
            }
            else if(txtPassword.text != txtConfirmPassword.text){
                self.showAlert(title: "Alert", message: "Please Enter correct Confirm Password")
            }
            else{
                
                if !isValidEmail(testStr: txtEmail.text!)
                {
                    self.showAlert(title: "Alert", message: "Please Enter vaild Email")
                }
                else if !isAgree
                {
                    self.showAlert(title: "Alert", message: "Please check the check box")
                }
                else
                {
                    
                    let urlString = User_Register + "email=" +  "\(String(describing: txtEmail.text!))" + "&pwd=" + "\(String(describing: txtPassword.text!))" + "&fightername=" + "\(String(describing: txtFightersName.text!))" + "&country=" + "\(CountryCode)"
                    
                    print(urlString)
                    

                    
                    Alamofire.request(urlString).responseJSON { response in
                        
                        print(JSON(response.result.value))
                        let temp = JSON(response.result.value)
                        
                        if(temp["message"] == "Success")
                        {
                            if(temp["response"]["isExist"] == "Yes")
                            {
                                self.showAlert(title: "Stop", message: "User Already Exit")
                            }
                            else
                            {
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
                                self.present(dashboard, animated: true, completion: nil)
                            }
                           
                        }
                        else
                        {
                           
                            self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                        }
                    }
                }
            }
            
        }
        
    }
    @IBAction func btnCancel(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signIn = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
        self.present(signIn, animated: true, completion: nil)
    }
    
    func PickerConfiguration()
    {
        
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
        
        
        picker.countryPickerDelegate = self
        picker.setCountry(code!)
        picker.backgroundColor = UIColor.black
        
        
    }
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        
        print(countryCode)
        
        //lblCountryName.text = name
        
        //imgFlag.image = UIImage(named: countryCode, in: Bundle(identifier: "org.cocoapods.CountryPicker"), compatibleWith: nil)
        
        //btnClosePicker.isHidden = true
        
        Country = name
        CountryCode = countryCode
        
        //picker.isHidden = true
        
    }
    
    @IBAction func btnClosePicker(_ sender: UIButton) {
        
        lblCountryName.text = Country
        imgFlag.image = UIImage(named: CountryCode)
        picker.isHidden = true
        btnClosePicker.isHidden = true
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
        
        txtEmail.inputAccessoryView = doneToolbar
        txtConfirmEmail.inputAccessoryView = doneToolbar
        txtPassword.inputAccessoryView = doneToolbar
        txtConfirmPassword.inputAccessoryView = doneToolbar
        txtFightersName.inputAccessoryView = doneToolbar
        
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    @IBAction func btnAgree(_ sender: UIButton) {
        
        if isAgree{
            
            imgAgree.image = UIImage(named: "ic_cb_unchecked")
            
            isAgree = false
        }
        else
        {
            imgAgree.image = UIImage(named: "ic_cb_checked")
            
            isAgree = true
        }
        
    }
    
    @IBAction func txtPasswordBegin(_ sender: UITextField) {
        
        self.view.frame.origin.y =  self.view.frame.origin.y - 50
    }
    @IBAction func txtPasswordEnd(_ sender: UITextField) {
        self.view.frame.origin.y =  self.view.frame.origin.y + 50
    }
    @IBAction func txtConfirmPasswordBegin(_ sender: UITextField) {
        self.view.frame.origin.y =  self.view.frame.origin.y - 100
    }
    @IBAction func txtConfirmPasswordEnd(_ sender: UITextField) {
        self.view.frame.origin.y =  self.view.frame.origin.y + 100
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
