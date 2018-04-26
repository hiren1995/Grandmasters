//
//  Dashboard.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 16/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import MarqueeLabel
import GTProgressBar
import Kingfisher

class Dashboard: UIViewController {

    @IBOutlet var imgFlag: UIImageView!
    @IBOutlet var lblName: MarqueeLabel!
    @IBOutlet var TotalHealthBar: GTProgressBar!
    @IBOutlet var lblTotalHealth: UILabel!
    @IBOutlet var lblXP: UILabel!
    @IBOutlet var lblPosition: UILabel!
    @IBOutlet var imgOnlineStatus: UIImageView!
    @IBOutlet var lblAccuracy: UILabel!
    @IBOutlet var lblMight: UILabel!
    @IBOutlet var lblAgility: UILabel!
    @IBOutlet var lblLevel: UILabel!
    @IBOutlet var imgProfilePic: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //loadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    @IBAction func btnTrainingRoom(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let trainingRoom = storyboard.instantiateViewController(withIdentifier: "trainingRoom") as! TrainingRoom
        self.present(trainingRoom, animated: true, completion: nil)
        
    }
    @IBAction func btnOnline(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playersOnline = storyboard.instantiateViewController(withIdentifier: "playersOnline") as! PlayersOnline
        self.present(playersOnline, animated: true, completion: nil)
        
    }
    
    @IBAction func btnArena(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let arena = storyboard.instantiateViewController(withIdentifier: "arena") as! Arena
        self.present(arena, animated: true, completion: nil)
        
    }
    @IBAction func btnLeaderBoard(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let leaderBoard = storyboard.instantiateViewController(withIdentifier: "leaderBoard") as! LeaderBoard
        self.present(leaderBoard, animated: true, completion: nil)
        
    }
    @IBAction func btnProfile(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyboard.instantiateViewController(withIdentifier: "profile") as! Profile
        self.present(profile, animated: true, completion: nil)
    }
    
    func loadData()
    {
      
        print(UserData)

        
        imgFlag.image = UIImage(named: UserData["Mem_Country"].stringValue)
        lblName.text = UserData["Mem_fightername"].stringValue
       
        TotalHealthBar.animateTo(progress: CGFloat(UserData["Mem_TotalHealthPoint"].floatValue))
        lblTotalHealth.text  = "\(UserData["Mem_TotalHealthPoint"].stringValue)/100"
        lblLevel.text = UserData["Mem_Level"].stringValue
        
        if(UserData["Mem_OnlineStatus"].intValue == 1)
        {
            imgOnlineStatus.image = UIImage(named: "ic_online")
        }
        else
        {
            imgOnlineStatus.image = UIImage(named: "ic_offline")
        }
        
        lblAccuracy.text = UserData["Mem_AccuracyCount"].stringValue
        lblMight.text = UserData["Mem_MightCount"].stringValue
        lblAgility.text = UserData["Mem_AgilityCount"].stringValue
        
        KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: "\(Image_URL)/\(UserData["Mem_Propic"].stringValue)")! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
            
            
            self.imgProfilePic.image = image
        })
 
    }
    
    @IBAction func btGamenStats(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyboard.instantiateViewController(withIdentifier: "profile") as! Fi
        self.present(profile, animated: true, completion: nil)
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
