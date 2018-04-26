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
    

    @IBOutlet var FightStatsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = FightStatsCollectionView.dequeueReusableCell(withReuseIdentifier: "fightStatsCollectionViewCell", for: indexPath) as! FightStatsCollectionViewCell
        
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
