//
//  BaseAPI.swift
//  ban
//
//  Created by mba on 16/8/22.
//  Copyright © 2016年 mbalib. All rights reserved.
//

import UIKit

/// 基础url
//let kBangBaseURL = "http://192.168.1.12:8096/api/"
var kBangBaseURL:String {
//    return "http://bang.dev.mbalib.com/api/"
//    return "http://192.168.1.130:8096/api/"
    return "http://192.168.1.12:8096/api/"
}

/// 用户模块
var kUserBaseURL:String{
    //    return "http://passport.mbalib.com/api2/"
    return "http://192.168.1.12:8082/api2/"
}

let kBangUserHelp = "http://bang.mbalib.com/user/help"
let kBangUserAbout = "http://bang.mbalib.com/user/about"


/*** 帮帮的 ***/

//微信
let kAppKeyWXID = "wx0cc2b5ee258ce00a"
let kAppKeyWXAppSecret = "acd5ff238f575a478014f478f9a560a1"
let kAppKeyWXMID = "1407994402"


/*** demo ***/
let kUmengAppkey = "57b432afe0f55a9832001a0a"
let kUmengRedirectURL = "http://mobile.umeng.com/social"

/*** 新浪 ***/
let kAppKeySinaID = "3921700954"
let kAppKeySinaAppSecret = "04b48b094faeb16683c32669824ebdad"
let kAppKeySinaRedirectURL = "http://sns.whalecloud.com/sina2/callback"


/*** QQ平台 ***/
let kAppQQ_ID = "100424468"
let kAppQQ_Key = "X5Vf1SCAJvj3ymC2"


