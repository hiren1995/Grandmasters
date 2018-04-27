//
//  TrainingRoom.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 30/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class TrainingRoom: UIViewController {

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
