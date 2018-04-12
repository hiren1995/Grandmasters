//
//  PlayersOnline.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 22/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class PlayersOnline: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let dict = [["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"],["random","Hiren","IN","2"],["random","abcdefghijklomopqr","PK","15"],["random","abcdefghijklomopqr","CN","30"],["random","Hiren","IN","40"]]
    
    @IBOutlet weak var PlayersOnlineCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PlayersOnlineCollectionView.delegate = self
        PlayersOnlineCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = PlayersOnlineCollectionView.dequeueReusableCell(withReuseIdentifier: "playersOnlineCollectionCell", for: indexPath) as! PlayersOnlineCollectionCell
        
        cell.imgProfilePic.image = UIImage(named: dict[indexPath.row][0])
        cell.lblName.text = dict[indexPath.row][1]
        cell.imgFlag.image = UIImage(named: dict[indexPath.row][2])
        cell.lblRank.text = dict[indexPath.row][3]
        
        return cell
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
