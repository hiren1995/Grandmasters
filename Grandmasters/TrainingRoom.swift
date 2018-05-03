//
//  TrainingRoom.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 30/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import SwiftyJSON
import GTProgressBar
import MBProgressHUD
import Alamofire


class TrainingRoom: UIViewController {

    @IBOutlet var imgPlayerFlag: UIImageView!
    @IBOutlet var lblPlayerName: UILabel!
    @IBOutlet var imgPlayerOnlineStatus: UIImageView!
    @IBOutlet var lblPlayerLevel: UILabel!
    @IBOutlet var PlayerHealthStatusBar: GTProgressBar!
    @IBOutlet var lblHealthStatus: UILabel!
    @IBOutlet var lblPower: UILabel!
    @IBOutlet var lblHealth: UILabel!
    @IBOutlet var lblMight: UILabel!
    @IBOutlet var lblAccuracy: UILabel!
    @IBOutlet var lblAgility: UILabel!
    @IBOutlet var lblMightBox: UILabel!
    @IBOutlet var lblAccuracyBox: UILabel!
    @IBOutlet var lblAgilityBox: UILabel!
    @IBOutlet var lblSkillPoints: UILabel!
    @IBOutlet var lblExtras: UILabel!
    
    var SkillPoints : Int = 0
    var powerValue : Int = 0
    var powerPoint : Int = 0
    var healthValue : Int = 0
    var healthPoint : Int = 0
    var Might : Int = 0
    var Accuracy : Int = 0
    var Agility : Int = 0
    var Extra : Int = 0
    var MightCount : Int = 0
    var AccuracyCount : Int = 0
    var AgilityCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadData()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnHome(_ sender: UIButton) {
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let updateTrainingParams:Parameters = ["UserId": userDefault.value(forKey: UserId)! ,"SkillPoint": SkillPoints,"PowerValue":powerValue,"PowerPoint":powerPoint,"HealthValue":healthValue,"HealthPoint":healthPoint,"TotalHealthPoint":healthPoint,"AccuracyCount":AccuracyCount,"AccuracyValue":Accuracy,"MightCount":MightCount,"MightValue":Might,"AgilityCount":AgilityCount,"AgilityValue":Agility,"Extras": Extra]
        print(updateTrainingParams)
        
        Alamofire.request(memberTrainingRoomUpdateAPI, method: .get, parameters: updateTrainingParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                
                
                print(JSON(response.result.value))
                
                let temp = JSON(response.result.value)
                
                
                
                if(temp["message"].stringValue == "Success")
                {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    UserData = temp["response_message"]["userdata"][0]
                    
                   self.dismiss(animated: true, completion: nil)
                    
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
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnStats(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fightStats = storyboard.instantiateViewController(withIdentifier: "fightStats") as! FightStats
        self.present(fightStats, animated: true, completion: nil)
    }
    
    func loadData()
    {
        print(UserData)
        
        imgPlayerFlag.image = UIImage(named: UserData["Mem_Country"].stringValue)
        lblPlayerName.text = UserData["Mem_fightername"].stringValue
        
        PlayerHealthStatusBar.animateTo(progress: CGFloat(UserData["Mem_TotalHealthPoint"].floatValue))
        lblHealthStatus.text  = "\(UserData["Mem_HealthPoint"].stringValue)/\(UserData["Mem_TotalHealthPoint"].stringValue)"
        lblPlayerLevel.text = UserData["Mem_Level"].stringValue
        
        if(UserData["Mem_OnlineStatus"].intValue == 1)
        {
            imgPlayerOnlineStatus.image = UIImage(named: "ic_online")
        }
        else
        {
            imgPlayerOnlineStatus.image = UIImage(named: "ic_offline")
        }
        
        SkillPoints = UserData["Mem_SkillPoint"].intValue
        
        lblSkillPoints.text = "Skill Points : \(String(SkillPoints)) sp"
        
        lblExtras.text = ": \(UserData["Mem_Extras"].stringValue)"
        
        powerValue = UserData["Mem_PowerValue"].intValue
        powerPoint = UserData["Mem_PowerPoint"].intValue
        
        lblPower.text = "\(UserData["Mem_PowerValue"].stringValue) (\(UserData["Mem_PowerPoint"].stringValue))"
        
        healthValue = UserData["Mem_HealthValue"].intValue
        healthPoint = UserData["Mem_HealthPoint"].intValue
        
        lblHealth.text = "\(UserData["Mem_HealthValue"].stringValue) (\(UserData["Mem_HealthPoint"].stringValue))"
        
        Might = UserData["Mem_MightValue"].intValue
        lblMight.text = UserData["Mem_MightValue"].stringValue
        Accuracy = UserData["Mem_AccuracyValue"].intValue
        lblAccuracy.text = UserData["Mem_AccuracyValue"].stringValue
        Agility = UserData["Mem_AgilityValue"].intValue
        lblAgility.text = UserData["Mem_AgilityValue"].stringValue
        
        MightCount = UserData["Mem_MightCount"].intValue
        lblMightBox.text = UserData["Mem_MightCount"].stringValue
        AccuracyCount = UserData["Mem_AccuracyCount"].intValue
        lblAccuracyBox.text = UserData["Mem_AccuracyCount"].stringValue
        AgilityCount = UserData["Mem_AgilityCount"].intValue
        lblAgilityBox.text = UserData["Mem_AgilityCount"].stringValue
    }
    
    @IBAction func btnPowerAdd(_ sender: UIButton) {
        
        SkillPoints = SkillPoints - 1
        powerValue = powerValue + 1
        powerPoint = powerPoint + 2
        lblSkillPoints.text = "Skill Points : \(String(SkillPoints)) sp"
        
        lblPower.text = "\(String(powerValue)) (\(String(powerPoint)))"
        
    }
    
    @IBAction func btnHealthAdd(_ sender: UIButton) {
        
        SkillPoints = SkillPoints - 1
        healthValue = healthValue + 1
        healthPoint = healthPoint + 10
        lblSkillPoints.text = "Skill Points : \(String(SkillPoints)) sp"
        
        lblHealth.text = "\(String(healthValue)) (\(String(healthPoint)))"
    }
    
    @IBAction func btnMightAdd(_ sender: UIButton) {
        
        SkillPoints = SkillPoints - 1
        Might = Might + 1
        
        lblSkillPoints.text = "Skill Points : \(String(SkillPoints)) sp"
        lblMight.text = "\(String(Might))"
        
        if(Might % 3 == 0)
        {
            MightCount = MightCount + 1
            lblMightBox.text = "\(MightCount)"
        }
        
    }
    
    @IBAction func btnAccuracyAdd(_ sender: UIButton) {
       
        SkillPoints = SkillPoints - 3
        Accuracy = Accuracy + 1
        
        lblSkillPoints.text = "Skill Points : \(String(SkillPoints)) sp"
        lblAccuracy.text = "\(String(Accuracy))"
        
        if(Accuracy % 3 == 0)
        {
            AccuracyCount = AccuracyCount + 1
            lblAccuracyBox.text = "\(AccuracyCount)"
        }
    }
    
    @IBAction func btnAgilityAdd(_ sender: UIButton) {
        
        SkillPoints = SkillPoints - 1
        Agility = Agility + 1
        
        lblSkillPoints.text = "Skill Points : \(String(SkillPoints)) sp"
        lblAgility.text = "\(String(Agility))"
        
        if(Agility % 3 == 0)
        {
            AgilityCount = AgilityCount + 1
            lblAgilityBox.text = "\(AgilityCount)"
        }
    }
    
    @IBAction func btnExtras(_ sender: UIButton) {
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
