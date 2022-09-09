//
//  HomeVC.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

class HomeVC: WJBaseViewController {

    private let homeAdapter = HomeAdapter()
    
    override func viewDidLoad() {
        registMVP(name: "Home")
        super.viewDidLoad()
        context.presenter.adapter = homeAdapter
        homeAdapter.adapterDelegate = self
        homeAdapter.adapterPullUpDelegate = self
        // 通过adapter建立我们的视图
        SendMsg<HomePresenterDelegate>.send(view, #selector(HomePresenterDelegate.buildHomeView(adapter:)), homeAdapter)
        // load数据
        SendMsg<HomePresenterDelegate>.send(context.presenter, #selector(HomePresenterDelegate.loadData(with:)), homeAdapter)
    }
}

extension HomeVC: WJBaseAdapterDelegate, WJBaseAdapterPullUpDelegate {
    
    func didSelect(cellData: Any) {
        SendMsg<HomePresenterDelegate>.send(context.interactor, #selector(HomePresenterDelegate.gotoLiveStream))
    }
    
    func loadMore() {
        print("加载下一页")
        // 让presenter去load下一页数据
        // SendMsg......
    }
}
