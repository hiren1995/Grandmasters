//
//  FightStats.swift
//  Grandmasters
//
//  Created by Apple on 20/04/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class FightStats: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var tempDict = JSON()
    @IBOutlet var FightStatsCollectionView: UICollectionView!
    
    var PlayerBlock1 = String()
    var PlayerBlock2 = String()
    var PlayerAttack = String()
    
    var OpponentBlock1 = String()
    var OpponentBlock2 = String()
    var OpponentAttack = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return 10
        return self.tempDict["roundData"].count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = FightStatsCollectionView.dequeueReusableCell(withReuseIdentifier: "fightStatsCollectionViewCell", for: indexPath) as! FightStatsCollectionViewCell
        
        cell.txtRound.text = "Round " + self.tempDict["roundData"][indexPath.row + 1]["FR_RoundNo"].stringValue
        
        print("Round \(self.tempDict["roundData"][indexPath.row + 1]["FR_RoundNo"].stringValue)")
        
        let PlayerMoveString = self.tempDict["roundData"][indexPath.row + 1]["FR_userMove"].stringValue
        let PlayerMoveArray = PlayerMoveString.components(separatedBy: "-")
        print("Players Move")
        print(PlayerMoveArray)
        PlayerBlock1 = PlayerMoveArray[0]
        PlayerBlock2 = PlayerMoveArray[1]
        PlayerAttack = PlayerMoveArray[2]
        
        let OpponentMoveString = self.tempDict["roundData"][indexPath.row + 1]["FR_oppoMove"].stringValue
        let OpponentMoveArray = OpponentMoveString.components(separatedBy: "-")
        print("Opponent Move")
        print(OpponentMoveArray)
        OpponentBlock1 = OpponentMoveArray[0]
        OpponentBlock2 = OpponentMoveArray[1]
        OpponentAttack = OpponentMoveArray[2]
        
        
        if(self.tempDict["userid"].intValue == userDefault.value(forKey: UserId) as! Int)
        {
            cell.lblFighterName.text = self.tempDict["user1Data"][0]["Mem_fightername"].stringValue
           
            cell.lblOpponentName.text = self.tempDict["user2Data"][0]["Mem_fightername"].stringValue
            
            //here if our user id is same as user1data userid then Player is player and opponent is opponent
            
            //Set images for Player
            
            // Conditions for playerBlock1
            
            if(PlayerBlock1 == "A")
            {
                cell.imgPlayerHeadBlocked.image = UIImage(named: "icon_block")
            }
            else if(PlayerBlock1 == "B")
            {
                cell.imgPlayerChestBlocked.image = UIImage(named: "icon_block")
            }
            else if(PlayerBlock1 == "C")
            {
                cell.imgPlayerThighBlocked.image = UIImage(named: "icon_block")
            }
            else
            {
                cell.imgPlayerLegBlocked.image = UIImage(named: "icon_block")
            }
            
            // Conditions for playerBlock2
            
            if(PlayerBlock2 == "A")
            {
                cell.imgPlayerHeadBlocked.image = UIImage(named: "icon_block")
            }
            else if(PlayerBlock2 == "B")
            {
                cell.imgPlayerChestBlocked.image = UIImage(named: "icon_block")
            }
            else if(PlayerBlock2 == "C")
            {
                cell.imgPlayerThighBlocked.image = UIImage(named: "icon_block")
            }
            else
            {
                cell.imgPlayerLegBlocked.image = UIImage(named: "icon_block")
            }
            
            // Conditions for playerAttack
            
            if(PlayerAttack == "A")
            {
                cell.imgOpponentHeadAttacked.image = UIImage(named: "icon_green")
            }
            else if(PlayerAttack == "B")
            {
                cell.imgOpponentChestAttacked.image = UIImage(named: "icon_green")
            }
            else if(PlayerAttack == "C")
            {
                cell.imgOpponentThighAttacked.image = UIImage(named: "icon_green")
            }
            else
            {
                cell.imgOpponentLegAttacked.image = UIImage(named: "icon_green")
                
            }
            
            
            // set images for opponent
            
            
            if(OpponentBlock1 == "A")
            {
                cell.imgOpponentHeadBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock1 == "B")
            {
                cell.imgOpponentChestBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock1 == "C")
            {
                cell.imgOpponentThighBlocked.image = UIImage(named: "icon_block")
            }
            else
            {
                cell.imgOpponentLegBlocked.image = UIImage(named: "icon_block")
            }
            
            // Conditions for playerBlock2
            
            if(OpponentBlock2 == "A")
            {
                cell.imgOpponentHeadBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock2 == "B")
            {
                cell.imgOpponentChestBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock2 == "C")
            {
                cell.imgOpponentThighBlocked.image = UIImage(named: "icon_block")
            }
            else
            {
                cell.imgOpponentLegBlocked.image = UIImage(named: "icon_block")
            }
            
            // Conditions for playerAttack
            
            if(OpponentAttack == "A")
            {
                cell.imgPlayerHeadAttacked.image = UIImage(named: "icon_green")
            }
            else if(PlayerAttack == "B")
            {
                cell.imgPlayer.image = UIImage(named: "icon_green")
            }
            else if(PlayerAttack == "C")
            {
                cell.imgOpponentThighAttacked.image = UIImage(named: "icon_green")
            }
            else
            {
                cell.imgOpponentLegAttacked.image = UIImage(named: "icon_green")
                
            }
        }
        else
        {
            cell.lblFighterName.text = self.tempDict["user2Data"][0]["Mem_fightername"].stringValue
            
            cell.lblOpponentName.text = self.tempDict["user1Data"][0]["Mem_fightername"].stringValue
            
            //here if our userid is not same as user1data userid then opponent is player and player is opponent
            
            if(OpponentBlock1 == "A")
            {
                cell.imgPlayerHeadBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock1 == "B")
            {
                cell.imgPlayerChestBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock1 == "C")
            {
                cell.imgPlayerThighBlocked.image = UIImage(named: "icon_block")
            }
            else
            {
                cell.imgPlayerLegBlocked.image = UIImage(named: "icon_block")
            }
            
            // Conditions for playerBlock2
            
            if(OpponentBlock2 == "A")
            {
                cell.imgPlayerHeadBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock2 == "B")
            {
                cell.imgPlayerChestBlocked.image = UIImage(named: "icon_block")
            }
            else if(OpponentBlock2 == "C")
            {
                cell.imgPlayerThighBlocked.image = UIImage(named: "icon_block")
            }
            else
            {
                cell.imgPlayerLegBlocked.image = UIImage(named: "icon_block")
            }
            
            // Conditions for playerAttack
            
            if(OpponentAttack == "A")
            {
                cell.imgOpponentHeadAttacked.image = UIImage(named: "icon_green")
            }
            else if(OpponentAttack == "B")
            {
                cell.imgOpponentChestAttacked.image = UIImage(named: "icon_green")
            }
            else if(OpponentAttack == "C")
            {
                cell.imgOpponentThighAttacked.image = UIImage(named: "icon_green")
            }
            else
            {
                cell.imgOpponentLegAttacked.image = UIImage(named: "icon_green")
                
            }
        }
        
        return cell
    }
    
    func loadData()
    {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let statsParams:Parameters = ["userid": "\(userDefault.value(forKey: UserId)!)"]
        
        Alamofire.request(getGameStatsAPI, method: .get, parameters: statsParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                print(JSON(response.result.value))
                
                self.tempDict = JSON(response.result.value)
                
                if(self.tempDict["message"].stringValue == "success")
                {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    self.FightStatsCollectionView.reloadData()
                    
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
