//
//  LeaderBoard.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 21/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import CountryPicker

class LeaderBoard: UIViewController,UITableViewDataSource,UITableViewDelegate,CountryPickerDelegate {
    
    let dict = [["1","IN","Hiren","Yes","2","150","2","India"],["2","IN","Jigar","No","2","150","1","India"],["3","CN","ChingchongPingPong","Yes","1","50","1","Afganisthannnnabdsfasbhd"]]
    
    var tempDict = JSON()
    var picker = CountryPicker()
    var Country = String()
    
    @IBOutlet weak var LeaderBoardTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LeaderBoardTable.delegate = self
        LeaderBoardTable.dataSource = self
        LeaderBoardTable.allowsSelection = false
        
        picker.countryPickerDelegate = self
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dict.count
    
        return self.tempDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LeaderBoardTable.dequeueReusableCell(withIdentifier: "leaderBoardTableCell", for: indexPath) as! LeaderBoardTableCell

        /*
         
        cell.lblPlace.text = dict[indexPath.row][0]
        cell.imgFlag.image = UIImage(named: dict[indexPath.row][1])
        cell.lblName.text = dict[indexPath.row][2]
        
        if(dict[indexPath.row][3] == "Yes")
        {
            cell.imgOnline.image = UIImage(named: "ic_online")
        }
        else
        {
            cell.imgOnline.image = UIImage(named: "ic_offline")
        }
        
        cell.lblRank.text = dict[indexPath.row][4]
        cell.lblXP.text = dict[indexPath.row][5]
        cell.lblLevel.text = dict[indexPath.row][6]
        cell.lblCountry.text = dict[indexPath.row][7]
         
        */
        
        cell.lblPlace.text = String(indexPath.row + 1)
        cell.imgFlag.image = UIImage(named: self.tempDict[indexPath.row]["Mem_Country"].stringValue)
        cell.lblName.text =  self.tempDict[indexPath.row]["Mem_fightername"].stringValue
        
        if(self.tempDict[indexPath.row]["Mem_OnlineStatus"].intValue == 1)
        {
            cell.imgOnline.image = UIImage(named: "ic_online")
        }
        else
        {
            cell.imgOnline.image = UIImage(named: "ic_offline")
        }
        
        cell.lblRank.text = self.tempDict[indexPath.row]["Mem_Level"].stringValue
        cell.lblXP.text = self.tempDict[indexPath.row]["Mem_XP"].stringValue
        cell.lblLevel.text = self.tempDict[indexPath.row]["Mem_Level"].stringValue
       
        let code = self.tempDict[indexPath.row]["Mem_Country"].stringValue
        picker.setCountry(code)
        
        cell.lblCountry.text = Country
        
        return cell
        
    }

    @IBAction func btnHome(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData()
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        Alamofire.request(getMemberListAPI).responseJSON { response in
            
            print(JSON(response.result.value))
            
            self.tempDict = JSON(response.result.value)
            
            print(self.tempDict.count)
            
            if(response.result.value != nil)
            {
                if(self.tempDict.count != 0)
                {
                    self.LeaderBoardTable.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            else
            {
                self.showAlert(title: "Alert", message: "Something Went wrong..!")
            }
            
            
        }
        
        
        
        /*
        Alamofire.request(getMemberListAPI, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                print(JSON(response.result.value))
                
                let temp = JSON(response.result.value)
                
                if(temp["message"] == "Success")
                {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                   
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
        */
    }
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        Country = name
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
