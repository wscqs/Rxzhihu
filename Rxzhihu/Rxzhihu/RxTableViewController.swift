//
//  RxTableViewController.swift
//  Rxzhihu
//
//  Created by mba on 16/12/26.
//  Copyright © 2016年 陈秋松. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import MJRefresh

class RxTableViewController: UIViewController {

    let tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    let reuseIdentifier = "\(UITableViewCell.self)"
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    var tmpViewModel: BaseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        dataSource.configureCell = {
            _, tableView, indexPath, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
            cell.tag = indexPath.row
            cell.textLabel?.text = user.screenName
            return cell
        }
        
        viewModel.getUsers()
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        
        

        
        
        if let vm = self.value(forKey: "viewModel") as? BaseViewModel {
            tmpViewModel = vm // 利用kvc设置tmpViewModel，这样就不需要在每个子类设置了
        }
        
        
        
    }
    /**
     设置刷新状态
     */
    func setUpRefreshStatus() {
        
        tmpViewModel?.refreshStatus.asObservable().bindNext { [unowned self] (status) in
            switch status {
            case .InvalidData:
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
                return
            case .DropDownSuccess:
                self.tableView.mj_footer.endRefreshing()
            case .PullSuccessHasMoreData:
                self.tableView.mj_footer.endRefreshing()
            case .PullSuccessNoMoreData:
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
            self.tableView.mj_header.endRefreshing()
            }.addDisposableTo(disposeBag)
    }
    
     func valueForUndefinedKey(key: String) -> Any? {
        if key == "viewModel" {
            return nil
        }
        return super.value(forUndefinedKey: key)
    }
    
    
}


class ViewModel: NSObject {
    
    func getUsers() -> Observable<[SectionModel<String, User>]> {
        return Observable.create { (observer) -> Disposable in
            let users = [User(followersCount: 19_901_990, followingCount: 1990, screenName: "Marco Sun"),
                         User(followersCount: 19_890_000, followingCount: 1989, screenName: "Taylor Swift"),
                         User(followersCount: 250_000, followingCount: 25, screenName: "Rihanna"),
                         User(followersCount: 13_000_000_000, followingCount: 13, screenName: "Jolin Tsai"),
                         User(followersCount: 25_000_000, followingCount: 25, screenName: "Adele")]
            let section = [SectionModel(model: "", items: users)]
            observer.onNext(section)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}

struct User {
    let followersCount: Int
    let followingCount: Int
    let screenName: String
}




enum RefreshStatus: Int {
    case DropDownSuccess // 下拉成功
    case PullSuccessHasMoreData // 上拉，还有更多数据
    case PullSuccessNoMoreData // 上拉，没有更多数据
    case InvalidData // 无效的数据
}
class BaseViewModel: NSObject {
    let disposeBag = DisposeBag()
    var refreshStatus = Variable.init(RefreshStatus.InvalidData)
    /**
     重写刷新方法，发射刷新信号
     */
//    override func updateData<List>( source: inout [List], list: [List], pullRefresh: Bool) {
//        super.updateData(&source, list: list, pullRefresh: pullRefresh)
//        // 刷新处理
//        if pullRefresh {  // 上拉刷新处理
//            self.refreshStatus.value = self.pageModel.hasNext ? .PullSuccessHasMoreData : .PullSuccessNoMoreData
//        } else { // 下拉刷新处理
//            self.refreshStatus.value = .DropDownSuccess
//        }
//    }
//    func revertCurrentPageAndRefreshStatus() {
//        // 修改刷新view的状态
//        self.refreshStatus.value = .InvalidData
//        // 还原请求页
//        self.pageModel.currentPage = self.pageModel.currentPage > 1 ? self.pageModel.currentPage - 1 : 1
//    }
}
//class PageModel {
//    static var hasNext = flase
//    static var currentPage = 1
//}
