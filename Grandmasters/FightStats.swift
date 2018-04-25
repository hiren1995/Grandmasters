//
//  FightStats.swift
//  Grandmasters
//
//  Created by Apple on 20/04/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class FightStats: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    

    @IBOutlet var FightStatsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = FightStatsCollectionView.dequeueReusableCell(withReuseIdentifier: "fightStatsCollectionViewCell", for: indexPath) as! FightStatsCollectionViewCell
        
        return cell
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
