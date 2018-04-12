
//
//  Profile.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 16/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import CountryPicker

class Profile: UIViewController,CountryPickerDelegate {
    
    @IBOutlet weak var txtFighterName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var imgFlag: UIImageView!
    
    @IBOutlet weak var lblSelectCountry: UILabel!
    @IBOutlet weak var lblCountryName: UILabel!
    
    @IBOutlet weak var picker: CountryPicker!
    @IBOutlet weak var btnClosePicker: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgFlag.isHidden = true
        lblCountryName.isHidden = true
        picker.isHidden = true
        btnClosePicker.isHidden = true
        
        PickerConfiguration()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnSelectCountry(_ sender: UIButton) {
        
        imgFlag.isHidden = false
        lblCountryName.isHidden = false
        lblSelectCountry.isHidden = true
        
        btnClosePicker.isHidden = false
        picker.isHidden = false
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
    @IBAction func txtPasswordBegin(_ sender: UITextField) {
        self.view.frame.origin.y = self.view.frame.origin.y - 50
    }
    @IBAction func txtPasswordEnd(_ sender: UITextField) {
        self.view.frame.origin.y = self.view.frame.origin.y + 50
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
        
        txtFighterName.inputAccessoryView = doneToolbar
        txtEmail.inputAccessoryView = doneToolbar
        txtPassword.inputAccessoryView = doneToolbar
        
        
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    @IBAction func btnChangeEmail(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfile = storyboard.instantiateViewController(withIdentifier: "editProfile") as! EditProfile
        editProfile.typeFlag = "email"
        self.present(editProfile, animated: true, completion: nil)
        
    }
    @IBAction func btnChangePassword(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfile = storyboard.instantiateViewController(withIdentifier: "editProfile") as! EditProfile
        editProfile.typeFlag = "password"
        self.present(editProfile, animated: true, completion: nil)
    }
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnHome(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
