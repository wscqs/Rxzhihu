//
//  ViewController.swift
//  Rxzhihu
//
//  Created by 陈秋松 on 2016/12/24.
//  Copyright © 2016年 陈秋松. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.skin.backgroundColor = ColorPicker.colors(UIColor.white,UIColor.black)
        let nightButton = UIButton(type: .custom)
        nightButton.skin.setTitle(.values("日间","夜间"), for: .normal)
        nightButton.skin.setTitleColor(ColorPicker.colors(UIColor.yellow,UIColor.blue), for: .normal)
        nightButton.skin.setBackgroundColor(ImagePicker.colors(UIColor.blue,UIColor.yellow), for: .normal)
        view.addSubview(nightButton)
        nightButton.frame = CGRect(x: 50, y: 50, width: 50, height: 30)

        nightButton.addTarget(self, action: #selector(ViewController.swichNight), for: .touchUpInside)
    }

    func swichNight() {
        switch ThemeManager.theme {
        case .day:
            ThemeManager.theme = .night
        case .night:
            ThemeManager.theme = .day
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

