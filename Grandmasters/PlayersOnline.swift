//
//  PlayersOnline.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 22/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import MarqueeLabel
import GTProgressBar
import MBProgressHUD

var selectedOpponent = JSON()
var followList = JSON()

class PlayersOnline: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let dict = [["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"]]
    
    var tempDict = JSON()
    var tempFollowDict = JSON()
    
    @IBOutlet weak var PlayersOnlineCollectionView: UICollectionView!
    @IBOutlet var ViewChallenge: UIView!
    @IBOutlet var lblPlayersCount: UILabel!
    
    @IBOutlet var lblRankFighter: UILabel!
    @IBOutlet var imgOnlineStatusFighter: UIImageView!
    @IBOutlet var imgFlagFighter: UIImageView!
    @IBOutlet var lblNameFighter: MarqueeLabel!
    @IBOutlet var TotalHealthBarFighter: GTProgressBar!
    @IBOutlet var lblTotalHealthFighter: UILabel!
    
    @IBOutlet var lblTotalHealthOpponent: UILabel!
    @IBOutlet var lblViewTitle: UILabel!
    @IBOutlet var imgFlagOpponent: UIImageView!
    @IBOutlet var TotalHealthBarOpponent: GTProgressBar!
    @IBOutlet var ProfileImgOpponent: UIImageView!
    @IBOutlet var lblRankOpponent: UILabel!
    @IBOutlet var imgOnlineStatusOpponent: UIImageView!
    @IBOutlet var lblNameOpponent: MarqueeLabel!
    @IBOutlet var btnFollowPlayer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PlayersOnlineCollectionView.delegate = self
        PlayersOnlineCollectionView.dataSource = self
        PlayersOnlineCollectionView.allowsMultipleSelection = false
        
        loadData()
        
        ViewChallenge.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return dict.count
        
        return tempDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = PlayersOnlineCollectionView.dequeueReusableCell(withReuseIdentifier: "playersOnlineCollectionCell", for: indexPath) as! PlayersOnlineCollectionCell
        
        /*
        cell.imgProfilePic.image = UIImage(named: dict[indexPath.row][0])
        cell.lblName.text = dict[indexPath.row][1]
        cell.imgFlag.image = UIImage(named: dict[indexPath.row][2])
        cell.lblRank.text = dict[indexPath.row][3]
        */
        
        
        cell.lblName.text = tempDict[indexPath.row]["Mem_fightername"].stringValue
        cell.imgFlag.image = UIImage(named: tempDict[indexPath.row]["Mem_Country"].stringValue)
        cell.lblRank.text = tempDict[indexPath.row]["Mem_Level"].stringValue
        
        if(tempDict[indexPath.row]["Mem_Propic"].stringValue != "")
        {
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: "\(Image_URL)/\(tempDict[indexPath.row]["Mem_Propic"].stringValue)")! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                cell.imgProfilePic.image = image
                
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = PlayersOnlineCollectionView.cellForItem(at: indexPath) as! PlayersOnlineCollectionCell
        
        cell.layer.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 0.5).cgColor
        
        selectedOpponent = tempDict[indexPath.row]
        
        print(selectedOpponent)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = PlayersOnlineCollectionView.cellForItem(at: indexPath) as! PlayersOnlineCollectionCell
        
        cell.layer.backgroundColor = UIColor.black.cgColor
    }
    
    @IBAction func btnHome(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData()
    {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        print("Inside load Data")
        print(UserData)
       
        imgFlagFighter.image = UIImage(named: UserData["Mem_Country"].stringValue)
        lblNameFighter.text = UserData["Mem_fightername"].stringValue
        
        TotalHealthBarFighter.animateTo(progress: CGFloat(UserData["Mem_TotalHealthPoint"].floatValue))
        lblTotalHealthFighter.text  = "\(UserData["Mem_TotalHealthPoint"].stringValue)/100"
        lblRankFighter.text = UserData["Mem_Level"].stringValue
        
        if(UserData["Mem_OnlineStatus"].intValue == 1)
        {
            imgOnlineStatusFighter.image = UIImage(named: "ic_online")
        }
        else
        {
            imgOnlineStatusFighter.image = UIImage(named: "ic_offline")
        }
        
        
        Alamofire.request(getMemberListAPI).responseJSON { response in
            
            print(JSON(response.result.value))
            
            self.tempDict = JSON(response.result.value)
            
            if(self.tempDict.count != 0)
            {
                self.PlayersOnlineCollectionView.reloadData()
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
        
        
        // Code for getting the follow list
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let followlistParams:Parameters = ["uid": "\(userDefault.value(forKey: UserId)!)"]
        
        Alamofire.request(getFollowListAPI, method: .get, parameters: followlistParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                
                
                print(JSON(response.result.value))
                
                self.tempFollowDict = JSON(response.result.value)
                
                if(self.tempFollowDict["message"].stringValue == "success")
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
        
    }
    
    @IBAction func btnFight(_ sender: UIButton) {
        
        if(selectedOpponent["Mem_Id"].stringValue == "")
        {
            selectedOpponent = tempDict[0]
        }
       
        lblNameOpponent.text = selectedOpponent["Mem_fightername"].stringValue
        imgFlagOpponent.image = UIImage(named: selectedOpponent["Mem_Country"].stringValue)
        lblRankOpponent.text = selectedOpponent["Mem_Level"].stringValue
        
        TotalHealthBarOpponent.animateTo(progress: CGFloat(selectedOpponent["Mem_TotalHealthPoint"].floatValue))
        
        if(selectedOpponent["Mem_OnlineStatus"].intValue == 1)
        {
            imgOnlineStatusOpponent.image = UIImage(named: "ic_online")
        }
        else
        {
            imgOnlineStatusOpponent.image = UIImage(named: "ic_offline")
        }
        
        if(selectedOpponent["Mem_Propic"].stringValue != "")
        {
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: "\(Image_URL)/\(selectedOpponent["Mem_Propic"].stringValue)")! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                self.ProfileImgOpponent.image = image
            })
        }
        
        
        
        ViewChallenge.isHidden = false
        
    }
    
    @IBAction func btnFightRequest(_ sender: Any) {
        
        let urlString = sendFightRequestAPI + "user=" +  "\(userDefault.value(forKey: UserId)!)" + "&opponent=" + "\(selectedOpponent["Mem_Id"].intValue)"
        
        print(urlString)
        
        
        
        Alamofire.request(urlString).responseJSON { response in
            
            print(JSON(response.result.value))
            
            let temp = JSON(response.result.value)
            
            if(temp["message"] == "success")
            {
               self.ViewChallenge.isHidden = true
                
                self.showAlert(title: "Request Sent", message: "Request sent Successfully")
                
            }
            else
            {
                
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        }
        
    }
    @IBAction func btnCancelChallenge(_ sender: UIButton) {
        
        ViewChallenge.isHidden = true
        
    }
    
    @IBAction func btnInfo(_ sender: Any) {
        
        lblViewTitle.text = "Info"
        
        if(selectedOpponent["Mem_Id"].stringValue != "")
        {
            lblNameOpponent.text = selectedOpponent["Mem_fightername"].stringValue
            imgFlagOpponent.image = UIImage(named: selectedOpponent["Mem_Country"].stringValue)
            
            lblRankOpponent.text = selectedOpponent["Mem_Level"].stringValue
            
            TotalHealthBarOpponent.animateTo(progress: CGFloat(selectedOpponent["Mem_TotalHealthPoint"].floatValue))
            
            if(selectedOpponent["Mem_OnlineStatus"].intValue == 1)
            {
                imgOnlineStatusOpponent.image = UIImage(named: "ic_online")
            }
            else
            {
                imgOnlineStatusOpponent.image = UIImage(named: "ic_offline")
            }
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: "\(Image_URL)/\(selectedOpponent["Mem_Propic"].stringValue)")! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                self.ProfileImgOpponent.image = image
            })
            
            ViewChallenge.isHidden = false
        }
        else
        {
            self.showAlert(title: "Alert", message: "Please Select an Opponent to get the Information")
        }
        
        
    }
    
    @IBAction func btnRandom(_ sender: UIButton) {
    
        if(tempDict.count != 0)
        {
            let random = randomNumber(n: tempDict.count)
            
            selectedOpponent = tempDict[random]
            lblNameOpponent.text = selectedOpponent["Mem_fightername"].stringValue
            imgFlagOpponent.image = UIImage(named: selectedOpponent["Mem_Country"].stringValue)
            lblRankOpponent.text = selectedOpponent["Mem_Level"].stringValue
            
            TotalHealthBarOpponent.animateTo(progress: CGFloat(selectedOpponent["Mem_TotalHealthPoint"].floatValue))
            
            if(selectedOpponent["Mem_OnlineStatus"].intValue == 1)
            {
                imgOnlineStatusOpponent.image = UIImage(named: "ic_online")
            }
            else
            {
                imgOnlineStatusOpponent.image = UIImage(named: "ic_offline")
            }
            
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: "\(Image_URL)/\(selectedOpponent["Mem_Propic"].stringValue)")! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                self.ProfileImgOpponent.image = image
            })
            
            ViewChallenge.isHidden = false
        }
        
    }
    
    @IBAction func btnFollowing(_ sender: UIButton) {
        
        /*
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let followlistParams:Parameters = ["uid": "\(userDefault.value(forKey: UserId)!)"]
        
        Alamofire.request(getFollowListAPI, method: .get, parameters: followlistParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                
                
                print(JSON(response.result.value))
                
                let temp = JSON(response.result.value)
                
                
                
                if(temp["message"].stringValue == "success")
                {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    var tempFollow = JSON()
                    
                    tempFollow = self.tempDict
                    
                    self.tempDict = []
        
                    for i in 0...temp["followlist"].count-1
                    {
                        for j in 0...tempFollow.count-1
                        {
                            if(temp["followlist"][i]["Fol_Following"].intValue == tempFollow[j]["Mem_Id"].intValue)
                            {
                                let x = tempFollow[j]
                                print(x)
                                
                                self.tempDict.arrayObject?.append(x)
                                
                            }
                        }
                        
                        
                    }
                    print(self.tempDict)
                    self.PlayersOnlineCollectionView.reloadData()
                    
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
        
        
        var tempFollow = JSON()
        
        tempFollow = self.tempDict
        
        self.tempDict = []
        
        for i in 0...self.tempFollowDict["followlist"].count-1
        {
            for j in 0...tempFollow.count-1
            {
                if(self.tempFollowDict["followlist"][i]["Fol_Following"].intValue == tempFollow[j]["Mem_Id"].intValue)
                {
                    let x = tempFollow[j]
                    print(x)
                    
                    self.tempDict.arrayObject?.append(x)
                    
                }
            }
            
            
        }
        print(self.tempDict)
        self.PlayersOnlineCollectionView.reloadData()
        
    }
    
    @IBAction func btnFollowOpponent(_ sender: UIButton) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let followParams:Parameters = ["follower": "\(userDefault.value(forKey: UserId)!)" , "following" : selectedOpponent["Mem_Id"].stringValue]
        
        Alamofire.request(followOpponentAPI, method: .get, parameters: followParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                
                
                print(JSON(response.result.value))
                
                let temp = JSON(response.result.value)
                
                
                
                if(temp["message"].stringValue == "success")
                {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    self.showAlert(title: "Success", message: "You started Following Successfully")
                    
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
    
    @IBAction func btnStats(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fightStats = storyboard.instantiateViewController(withIdentifier: "fightStats") as! FightStats
        self.present(fightStats, animated: true, completion: nil)
    }
    
    func randomNumber(n : Int) -> Int {
        
         return Int(arc4random_uniform(UInt32(n)))
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
