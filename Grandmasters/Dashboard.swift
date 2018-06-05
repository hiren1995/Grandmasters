//
//  Dashboard.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 16/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import MarqueeLabel
import GTProgressBar
import Kingfisher
import CropViewController
import Alamofire
import SwiftyJSON
import MBProgressHUD

class Dashboard: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropViewControllerDelegate {

    @IBOutlet var imgFlag: UIImageView!
    @IBOutlet var lblName: MarqueeLabel!
    @IBOutlet var TotalHealthBar: GTProgressBar!
    @IBOutlet var lblTotalHealth: UILabel!
    @IBOutlet var lblXP: UILabel!
    @IBOutlet var lblPosition: UILabel!
    @IBOutlet var imgOnlineStatus: UIImageView!
    @IBOutlet var lblAccuracy: UILabel!
    @IBOutlet var lblMight: UILabel!
    @IBOutlet var lblAgility: UILabel!
    @IBOutlet var lblLevel: UILabel!
    @IBOutlet var imgProfilePic: UIImageView!
    @IBOutlet var lblWinDrawLose: UILabel!
    
    
    
    
    @IBOutlet var ChallengeView: UIView!
    
    
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fightChallengeReceived(notification:)), name: NSNotification.Name("FightChallenge"), object: nil)
        
        ChallengeView.isHidden = true

        //loadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
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
    
    func loadData()
    {
      
        print(UserData)

        
        imgFlag.image = UIImage(named: UserData["Mem_Country"].stringValue)
        lblName.text = UserData["Mem_fightername"].stringValue
       
        TotalHealthBar.animateTo(progress: CGFloat(UserData["Mem_TotalHealthPoint"].floatValue))
        lblTotalHealth.text  = "\(UserData["Mem_HealthPoint"].stringValue)/\(UserData["Mem_TotalHealthPoint"].stringValue)"
        lblLevel.text = UserData["Mem_Level"].stringValue
        
        if(UserData["Mem_OnlineStatus"].intValue == 1)
        {
            imgOnlineStatus.image = UIImage(named: "ic_online")
        }
        else
        {
            imgOnlineStatus.image = UIImage(named: "ic_offline")
        }
        
        lblAccuracy.text = UserData["Mem_AccuracyCount"].stringValue
        lblMight.text = UserData["Mem_MightCount"].stringValue
        lblAgility.text = UserData["Mem_AgilityCount"].stringValue
        
        KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: "\(Image_URL)/\(UserData["Mem_Propic"].stringValue)")! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
            
            
            self.imgProfilePic.image = image
        })
 
        lblXP.text = "XP : \(UserData["Mem_XP"].stringValue)"
        lblPosition.text = "POS : \(UserData["Mem_Pos"].stringValue)"
        lblWinDrawLose.text = "\(UserData["Mem_Win"].stringValue)-\(UserData["Mem_Draw"].stringValue)-\(UserData["Mem_Lose"].stringValue) (W-D-L)"
    }
    
    @IBAction func btGamenStats(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fightStats = storyboard.instantiateViewController(withIdentifier: "fightStats") as! FightStats
        self.present(fightStats, animated: true, completion: nil)
    }
    
    @IBAction func btnProfilePic(_ sender: UIButton) {
        
        ChangeProfilePic()
    }
    @IBAction func btnProfilePic2(_ sender: UIButton) {
        ChangeProfilePic()
    }
    
    func ChangeProfilePic()
    {
        var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        var gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            //profileImg.image = image
            
            self.dismiss(animated: true, completion: nil)
            let cropViewController = CropViewController(image: image)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
            
        } else{
            print("Something went wrong")
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        //imgProfilePic.image = image
        
        let imgbase64Str = convertImageToBase64(image: image)
        
        print(imgbase64Str)
        
        
        
        let updateProfilePicParams:Parameters = ["uid": "\(userDefault.value(forKey: UserId)!)" , "propic" : imgbase64Str]
        
        Alamofire.request(updateProfilePicAPI, method: .post, parameters: updateProfilePicParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                print(JSON(response.result.value))
                
                
                let tempDict = JSON(response.result.value)
                
                if(tempDict["status"].stringValue == "updated")
                {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                 
                    UserData = tempDict["userdata"][0]
                 
                    self.dismiss(animated: true, completion: nil)
                    self.imgProfilePic.image = image
                    
                }
                else
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                }
                
            }
            else
            {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Error in Getting Response")
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
    }
    
    
    @objc func fightChallengeReceived (notification : NSNotification)
    {
        print(notification)
        print("Notification Received")
        
        ChallengeView.isHidden = false
        
        //print(notification.object)
        
        /*
         let dataDic = notification.object as? NSDictionary
         let fromId = dataDic?["chat_random_id"] as? String
         print("Notification Chat Random id:\(fromId)")
         print("Chat Random Id is:\(strChatRandomID)")
         if fromId == strChatRandomID
         {
         getAllMessages()
         }
         
         */
        
        //LoadMessages()
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
