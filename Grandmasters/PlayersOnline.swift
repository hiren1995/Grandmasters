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


class PlayersOnline: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let dict = [["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"]]
    
    var tempDict = JSON()
    
    @IBOutlet weak var PlayersOnlineCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PlayersOnlineCollectionView.delegate = self
        PlayersOnlineCollectionView.dataSource = self
        PlayersOnlineCollectionView.allowsMultipleSelection = false
        
        loadData()
        
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
        
        
        KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: "\(Image_URL)/\(tempDict[indexPath.row]["Mem_Propic"].stringValue)")! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
            
            
            cell.imgProfilePic.image = image
            
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = PlayersOnlineCollectionView.cellForItem(at: indexPath) as! PlayersOnlineCollectionCell
        
        cell.layer.backgroundColor = UIColor.lightGray.cgColor
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
        
        Alamofire.request(getMemberListAPI).responseJSON { response in
            
            print(JSON(response.result.value))
            
            self.tempDict = JSON(response.result.value)
            
            if(self.tempDict.count != 0)
            {
                self.PlayersOnlineCollectionView.reloadData()
            }
            
        }
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
