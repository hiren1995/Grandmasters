//
//  EditProfile.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 17/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

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
        }
        else
        {
            lblFirst.text = "Current Password"
            lblSecond.text = "New Password"
            lblThird.text = "Confirm Password"
        }
    }
    @IBAction func btnCancel(_ sender: UIButton) {
        
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
