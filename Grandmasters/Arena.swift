//
//  Arena.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 24/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import GTProgressBar



var head_attack:Bool = false
var chest_attack:Bool = false
var thigh_attack:Bool = false
var leg_attack:Bool = false

var head_block:Bool = false
var chest_block:Bool = false
var thigh_block:Bool = false
var leg_block:Bool = false


//opponent moves here

var opponentHeadAttack:Bool = true
var opponentChestAttack:Bool = false
var opponentThighAttack:Bool = false
var opponentLegAttack:Bool = false

var opponentBlockedHead:Bool = true
var opponentBlockedChest:Bool = false
var opponentBlockedThigh:Bool = false
var opponentBlockedLeg:Bool = true




var blockCounter:Int = 0
var attackCounter:Int = 0

class Arena: UIViewController {

    @IBOutlet weak var btnHeadBlock: UIButton!
    @IBOutlet weak var btnChestBlock: UIButton!
    @IBOutlet weak var btnThighBlock: UIButton!
    @IBOutlet weak var btnLegBlock: UIButton!
    @IBOutlet weak var btnHeadAttack: UIButton!
    @IBOutlet weak var btnChestAttack: UIButton!
    @IBOutlet weak var btnThighAttack: UIButton!
    @IBOutlet weak var btnLegAttack: UIButton!
    
    @IBOutlet weak var btnGo: UIButton!
    
    @IBOutlet weak var ViewAttack: UIView!
    
    @IBOutlet weak var lblTimer: UILabel!
    
    @IBOutlet weak var ProgressBar: GTProgressBar!
    
    
    var countdownTimer: Timer!
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ProgressBar.progress = 1
        
        
        btnHeadBlock.setBackgroundImage(UIImage(named: "ic_head"), for: .selected)
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        startTimer()
    }
   
    
    @IBAction func btnHeadBlock(_ sender: UIButton) {
        
        HeadBlock()
    }
    @IBAction func btnChestBlock(_ sender: UIButton) {
        
        ChestBlock()
        
    }
    @IBAction func btnThighBlock(_ sender: UIButton) {
        
        ThighBlock()
    }
    @IBAction func btnLegBlock(_ sender: UIButton) {
        
        LegBlock()
        
    }
    
    
    @IBAction func btnHeadAttack(_ sender: UIButton) {
        
        HeadAttack()
    }
    @IBAction func btnChestAttack(_ sender: UIButton) {
        
        ChestAttack()
    }
    @IBAction func btnThighAttack(_ sender: UIButton) {
        
        ThighAttack()
    }
    @IBAction func btnLegAttack(_ sender: UIButton) {
        
        LegAttack()
    }
    
    
    @IBAction func btnGoAction(_ sender: UIButton) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let result = storyboard.instantiateViewController(withIdentifier: "result") as! Result
        
        self.present(result, animated: false, completion: nil)
        
        
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
    
    func HeadBlock()
    {
        
        
        if head_block
        {
            btnHeadBlock.setBackgroundImage(UIImage(named: "ic_head"), for: .normal)
            head_block = false
            
            if(blockCounter != 0)
            {
                blockCounter = blockCounter-1
            }
        }
        else
        {
            if(blockCounter != 2)
            {
                btnHeadBlock.setBackgroundImage(UIImage(named: "ic_head_protect"), for: .normal)
                head_block = true
                blockCounter = blockCounter+1
            }
        }
    }
    func ChestBlock()
    {
        if chest_block
        {
            btnChestBlock.setBackgroundImage(UIImage(named: "ic_chest"), for: .normal)
            chest_block = false
            
            if(blockCounter != 0)
            {
                blockCounter = blockCounter-1
            }
        }
        else
        {
            if(blockCounter != 2)
            {
                btnChestBlock.setBackgroundImage(UIImage(named: "ic_chest_protect"), for: .normal)
                chest_block = true
                blockCounter = blockCounter+1
            }
        }
    }
    
    func ThighBlock()
    {
        if thigh_block
        {
            btnThighBlock.setBackgroundImage(UIImage(named: "ic_thigh"), for: .normal)
            thigh_block = false
            
            if(blockCounter != 0)
            {
                blockCounter = blockCounter-1
            }
        }
        else
        {
            if(blockCounter != 2)
            {
                btnThighBlock.setBackgroundImage(UIImage(named: "ic_thigh_protect"), for: .normal)
                thigh_block = true
                blockCounter = blockCounter+1
            }
        }
        
    }
    
    func LegBlock()
    {
        if leg_block
        {
            btnLegBlock.setBackgroundImage(UIImage(named: "ic_leg"), for: .normal)
            leg_block = false
            
            if(blockCounter != 0)
            {
                blockCounter = blockCounter-1
            }
        }
        else
        {
            if(blockCounter != 2)
            {
                btnLegBlock.setBackgroundImage(UIImage(named: "ic_leg_protect"), for: .normal)
                leg_block = true
                blockCounter = blockCounter+1
            }
        }
    }
    
    func HeadAttack()
    {
        if head_attack
        {
            btnHeadAttack.setBackgroundImage(UIImage(named: "ic_head"), for: .normal)
            head_attack = false
            
            if(attackCounter != 0)
            {
                attackCounter = attackCounter-1
            }
        }
        else
        {
            if(attackCounter != 1)
            {
                btnHeadAttack.setBackgroundImage(UIImage(named: "ic_head_hit"), for: .normal)
                head_attack = true
                attackCounter = attackCounter+1
            }
        }
    }
    func ChestAttack()
    {
        if chest_attack
        {
            btnChestAttack.setBackgroundImage(UIImage(named: "ic_chest"), for: .normal)
            chest_attack = false
            
            if(attackCounter != 0)
            {
                attackCounter = attackCounter-1
            }
        }
        else
        {
            if(attackCounter != 1)
            {
                btnChestAttack.setBackgroundImage(UIImage(named: "ic_chest_hit"), for: .normal)
                chest_attack = true
                attackCounter = attackCounter+1
            }
        }
    }
    func ThighAttack()
    {
        if thigh_attack
        {
            btnThighAttack.setBackgroundImage(UIImage(named: "ic_thigh"), for: .normal)
            thigh_attack = false
            
            if(attackCounter != 0)
            {
                attackCounter = attackCounter-1
            }
        }
        else
        {
            if(attackCounter != 1)
            {
                btnThighAttack.setBackgroundImage(UIImage(named: "ic_thigh_hit"), for: .normal)
                thigh_attack = true
                attackCounter = attackCounter+1
            }
        }
    }
    
    func LegAttack()
    {
        if leg_attack
        {
            btnLegAttack.setBackgroundImage(UIImage(named: "ic_leg"), for: .normal)
            leg_attack = false
            
            if(attackCounter != 0)
            {
                attackCounter = attackCounter-1
            }
        }
        else
        {
            if(attackCounter != 1)
            {
                btnLegAttack.setBackgroundImage(UIImage(named: "ic_leg_hit"), for: .normal)
                leg_attack = true
                attackCounter = attackCounter+1
            }
        }
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
