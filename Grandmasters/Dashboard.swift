//
//  Dashboard.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 16/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
