//
//  SideMenuViewController.swift
//  Rxzhihu
//
//  Created by 陈秋松 on 2016/12/25.
//  Copyright © 2016年 陈秋松. All rights reserved.
//

import UIKit
import SnapKit

class SideMenuViewController: UIViewController {

    var scrollView: UIScrollView!
    var scrollContentView: UIView!
    
    var leftViewController: UIViewController!
    var mainViewController: UIViewController!

    
    convenience init(leftViewController: UIViewController, mainViewController: UIViewController) {
        self.init()
        self.leftViewController = leftViewController
        self.mainViewController = mainViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindObserver()
        view.backgroundColor = UIColor.red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint(x: 0.5 * scrollView.width, y: 0), animated: false)
    }
    
    deinit {
        self.removeObserver()
    }
    
    fileprivate func setupView() {
        automaticallyAdjustsScrollViewInsets = false
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SideMenuViewController.scrollToMainView))
        tapRecognizer.delegate = self
        scrollView.addGestureRecognizer(tapRecognizer)
        scrollView.contentSize = CGSize(width: view.width * 1.5, height: view.height)
        
        scrollContentView = UIView()
        scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints { (make) in
            make.left.top.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.width.equalTo(scrollView).multipliedBy(1.5)
        }
        
        
        addChildViewController(leftViewController)
        scrollContentView.addSubview(leftViewController.view)
        leftViewController.view.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.scrollContentView)
            make.width.equalTo(self.scrollContentView).multipliedBy(1/3.0)
        }
        addChildViewController(mainViewController)
        scrollContentView.addSubview(mainViewController.view)
        mainViewController.view.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self.scrollContentView)
            make.width.equalTo(scrollContentView).multipliedBy(2/3.0)
        }
    }
    
    func bindObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(SideMenuViewController.scrollLeftView), name: NSNotification.Name.SliderMenu.ShowMenuView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SideMenuViewController.scrollToMainView), name: NSNotification.Name.SliderMenu.HideMenuView, object: nil)
    }
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollLeftView() {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func scrollToMainView() {
        scrollView.setContentOffset(CGPoint(x: 0.5 * scrollView.width, y: 0), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SideMenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let shouldReceiveTouch = (scrollView.contentOffset.x == 0 && (touch.location(in: scrollView).x >= scrollView.width / 2))
        WLYLog.d("shouldReceiveTouch: \(shouldReceiveTouch)")
        return shouldReceiveTouch
    }
}
