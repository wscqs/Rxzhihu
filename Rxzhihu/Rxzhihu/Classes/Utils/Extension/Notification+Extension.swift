//
//  Notification+Extension.swift
//  Rxzhihu
//
//  Created by 陈秋松 on 2016/12/24.
//  Copyright © 2016年 陈秋松. All rights reserved.
//

import UIKit

extension Notification {
    /// Used as a namespace for all `Notification` user info dictionary keys.
    public struct Key {
        /// User info dictionary key representing the `URLSessionTask` associated with the notification.
        public static let Task = "org.alamofire.notification.key.task"
    }
}


extension Notification.Name {    
    public struct SliderMenu {
        public static let ShowMenuView = Notification.Name(rawValue: "SliderMenuViewController.ShowMenuView")
        public static let HideMenuView = Notification.Name(rawValue: "HideMenuView")
    }
}
