//
//  AppDelegate.swift
//  Rxzhihu
//
//  Created by 陈秋松 on 2016/12/24.
//  Copyright © 2016年 陈秋松. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        WLYLog.setup()
        let vc = HomeSideViewController()
        let rootViewController = SideMenuViewController(leftViewController: vc, mainViewController: RxTableViewController())
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

