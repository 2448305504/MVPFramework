//
//  HomeView.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

class HomeView: CDDView {
    
    private var tableView: UITableView!
    
    required init() {
        super.init()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension HomeView: HomePresenterDelegate {
    
    func buildHomeView(adapter: HomeAdapter) {
        let tableView = UITableView(frame: bounds, style: .plain)
        tableView.clipsToBounds = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "HomeCell", bundle: .main), forCellReuseIdentifier: "HomeCell")
        addSubview(tableView)
        self.tableView = tableView
        // 设置代理为适配器
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    func reloadView() {
        debugPrint("reloadView")
        tableView.reloadData()
    }
}
