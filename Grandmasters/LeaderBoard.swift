//
//  LeaderBoard.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 21/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit


class LeaderBoard: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let dict = [["1","IN","Hiren","Yes","2","150","2","India"],["2","IN","Jigar","No","2","150","1","India"],["3","CN","ChingchongPingPong","Yes","1","50","1","Afganisthannnnabdsfasbhd"]]

    @IBOutlet weak var LeaderBoardTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LeaderBoardTable.delegate = self
        LeaderBoardTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LeaderBoardTable.dequeueReusableCell(withIdentifier: "leaderBoardTableCell", for: indexPath) as! LeaderBoardTableCell
        
        cell.lblPlace.text = dict[indexPath.row][0]
        cell.imgFlag.image = UIImage(named: dict[indexPath.row][1])
        cell.lblName.text = dict[indexPath.row][2]
        
        if(dict[indexPath.row][3] == "Yes")
        {
            cell.imgOnline.image = UIImage(named: "ic_online")
        }
        else
        {
            cell.imgOnline.image = UIImage(named: "ic_offline")
        }
        
        cell.lblRank.text = dict[indexPath.row][4]
        cell.lblXP.text = dict[indexPath.row][5]
        cell.lblLevel.text = dict[indexPath.row][6]
        cell.lblCountry.text = dict[indexPath.row][7]
        
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
