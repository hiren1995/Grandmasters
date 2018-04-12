//
//  Result.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 27/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import GTProgressBar

class Result: UIViewController {

    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var ProgressBar: GTProgressBar!
    
    @IBOutlet weak var PlayerHeadAttacked: UIImageView!
    @IBOutlet weak var PlayerChestAttacked: UIImageView!
    @IBOutlet weak var PlayerThighAttacked: UIImageView!
    @IBOutlet weak var PlayerLegAttacked: UIImageView!
    
    @IBOutlet weak var PlayerBlockedHead: UIImageView!
    @IBOutlet weak var PlayerBlockedChest: UIImageView!
    @IBOutlet weak var PlayerBlockedThigh: UIImageView!
    @IBOutlet weak var PlayerBlockedLeg: UIImageView!
    
    
    @IBOutlet weak var OpponentHeadAttacked: UIImageView!
    @IBOutlet weak var OpponentChestAttacked: UIImageView!
    @IBOutlet weak var OpponentThighAttacked: UIImageView!
    @IBOutlet weak var OpponentLegAttacked: UIImageView!
    
    @IBOutlet weak var OpponentBlockedHead: UIImageView!
    @IBOutlet weak var OpponentBlockedChest: UIImageView!
    @IBOutlet weak var OpponentBlockedThigh: UIImageView!
    @IBOutlet weak var OpponentBlockedLeg: UIImageView!
    
    var countdownTimer: Timer!
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startTimer()
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        lblTimer.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
            ProgressBar.animateTo(progress: CGFloat(totalTime)/60)
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        
        //let seconds: Int = totalSeconds % 60
        //let minutes: Int = (totalSeconds / 60) % 60
        //let hours: Int = totalSeconds / 3600
        //return String(format: "%02d:%02d", minutes, seconds)
        
        
        return String(format: "%02d",totalSeconds)
    }

    func loadData()
    {
        if opponentHeadAttack
        {
            PlayerHeadAttacked.image = UIImage(named: "icon_blue")
        }
        if opponentChestAttack
        {
            PlayerChestAttacked.image = UIImage(named: "icon_blue")
        }
        if opponentThighAttack
        {
            PlayerThighAttacked.image = UIImage(named: "icon_blue")
        }
        if opponentLegAttack
        {
            PlayerLegAttacked.image = UIImage(named: "icon_blue")
        }
        
        
        //blocked by player
        
        if head_block
        {
            PlayerBlockedHead.image = UIImage(named: "icon_block")
        }
        if chest_block
        {
            PlayerBlockedChest.image = UIImage(named: "icon_block")
        }
        if thigh_block
        {
            PlayerBlockedThigh.image = UIImage(named: "icon_block")
        }
        if leg_block
        {
            PlayerBlockedLeg.image = UIImage(named: "icon_block")
        }
        
        
        
        //for Opponent
        
        //attack by Player on opponent
        if head_attack
        {
            OpponentHeadAttacked.image = UIImage(named: "icon_green")
        }
        if chest_attack
        {
            OpponentChestAttacked.image = UIImage(named: "icon_green")
        }
        if thigh_attack
        {
            OpponentThighAttacked.image = UIImage(named: "icon_green")
        }
        if leg_attack
        {
            OpponentLegAttacked.image = UIImage(named: "icon_green")
        }
        
        
        //blocked by opponent
        
        if opponentBlockedHead
        {
            OpponentBlockedHead.image = UIImage(named: "icon_block")
        }
        if opponentBlockedChest
        {
            OpponentBlockedChest.image = UIImage(named: "icon_block")
        }
        if opponentBlockedThigh
        {
            OpponentBlockedThigh.image = UIImage(named: "icon_block")
        }
        if opponentBlockedLeg
        {
            OpponentBlockedLeg.image = UIImage(named: "icon_block")
        }
        
    }
    
    @IBAction func btnReady(_ sender: UIButton) {
        
         head_attack = false
         chest_attack  = false
         thigh_attack = false
         leg_attack = false
        
         head_block = false
         chest_block = false
         thigh_block = false
         leg_block = false
        
        
        //opponent moves here
        
         opponentHeadAttack = true
         opponentChestAttack = false
         opponentThighAttack = false
         opponentLegAttack = false
        
         opponentBlockedHead = true
         opponentBlockedChest = false
         opponentBlockedThigh = false
         opponentBlockedLeg = true
        
        blockCounter = 0
        attackCounter = 0
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let arena = storyboard.instantiateViewController(withIdentifier: "arena") as! Arena
        
        self.present(arena, animated: false, completion: nil)
        
    }
    
    @IBAction func btnHome(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
        
        self.present(dashboard, animated: true, completion: nil)
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
