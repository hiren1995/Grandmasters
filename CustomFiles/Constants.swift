//
//  Constants.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 13/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import Foundation

var userDefault = UserDefaults.standard

var UserId = "UserId"
var DeviceToken = "DeviceToken"
var isLogin = "isLogin"
var loginParam = "LoginParam"


// API calls url list


var Base_URL = "https://thegrandmastersapp.com/admin/api/index.php"
var Image_URL = "https://www.thegrandmastersapp.com/admin/api/images/"
var User_RegisterAPI = "\(Base_URL)/member/register?"
var UserLoginAPI = "\(Base_URL)/member/memberlogin?"
var getMemberListAPI = "\(Base_URL)/member/memberlist"
var sendFightRequestAPI = "\(Base_URL)/member/requestFight?"
var getLeaderBoardAPI = "\(Base_URL)/member/leaderboard"
var getGameStatsAPI = "\(Base_URL)/member/getStatistic"


