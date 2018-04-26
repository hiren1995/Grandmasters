//
//  FightStatsCollectionViewCell.swift
//  Grandmasters
//
//  Created by Apple on 25/04/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class FightStatsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lblFighterName: UILabel!
    @IBOutlet var lblOpponentName: UILabel!
    
    @IBOutlet var imgPlayerHeadAttacked: UIImageView!
    @IBOutlet var imgPlayerHeadBlocked: UIImageView!
    @IBOutlet var imgPlayerChestAttacked: UIImageView!
    @IBOutlet var imgPlayerChestBlocked: UIImageView!
    @IBOutlet var imgPlayerThighAttacked: UIImageView!
    @IBOutlet var imgPlayerThighBlocked: UIImageView!
    @IBOutlet var imgPlayerLegAttacked: UIImageView!
    @IBOutlet var imgPlayerLegBlocked: UIImageView!
    
    
    @IBOutlet var imgOpponentHeadAttacked: UIImageView!
    @IBOutlet var imgOpponentHeadBlocked: UIImageView!
    @IBOutlet var imgOpponentChestAttacked: UIImageView!
    @IBOutlet var imgOpponentChestBlocked: UIImageView!
    @IBOutlet var imgOpponentThighAttacked: UIImageView!
    @IBOutlet var imgOpponentThighBlocked: UIImageView!
    @IBOutlet var imgOpponentLegAttacked: UIImageView!
    @IBOutlet var imgOpponentLegBlocked: UIImageView!
}
