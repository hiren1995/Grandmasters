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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnHome(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnStats(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fightStats = storyboard.instantiateViewController(withIdentifier: "fightStats") as! FightStats
        self.present(fightStats, animated: true, completion: nil)
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
