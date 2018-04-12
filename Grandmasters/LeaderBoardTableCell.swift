//
//  LeaderBoardTableCell.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 21/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import MarqueeLabel

class LeaderBoardTableCell: UITableViewCell {

    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblName: MarqueeLabel!
    @IBOutlet weak var imgOnline: UIImageView!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblXP: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblCountry: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
