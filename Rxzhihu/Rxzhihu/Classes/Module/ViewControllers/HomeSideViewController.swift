//
//  HomeSideViewController.swift
//  Rxzhihu
//
//  Created by mba on 16/12/26.
//  Copyright © 2016年 陈秋松. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift
import ReusableKit
import Then

class HomeSideViewController: BaseViewController {

    let headerViewHeight: CGFloat = 125
    let footerViewHeight: CGFloat = 60
    
    struct Reusable {
        static let homeSideCell = ReusableCell<HomeSideCell>()
    }
    
    var headerView: UIView!
    var footerView: UIView!
    let tableView = UITableView().then {
        $0.register(Reusable.homeSideCell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }
    
    func setupView() {
        view.backgroundColor = UIColor.black
        view.addSubview(tableView)
        tableView.rx.setDelegate(self).addDisposableTo(self.disposeBag)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }

}

// MARK: - UITableViewDelegate

extension HomeSideViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
