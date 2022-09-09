//
//  HomePresenter.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

@objc protocol HomePresenterDelegate: NSObjectProtocol {
    // 通过adapter建立我们的视图 : 主要是数据与视图的绑定
    @objc optional func buildHomeView(adapter: HomeAdapter)
    // 加载数据
    @objc optional func loadData(with adapter: HomeAdapter)
    // UI去刷新界面了
    @objc optional func reloadView()
    // 去直播间
    @objc optional func gotoLiveStream()
}

// 主持人
class HomePresenter: CDDPresenter, HomePresenterDelegate {
    public var models: [HomeProfile] = []
    
    // 请求数据
    func loadData(with adapter: HomeAdapter) {
        // 数据准备
        for i in 0..<40 {
            let homeModel = HomeProfile()
            homeModel.brandId = "\(i)"
            homeModel.brandName = "姿势从未如此性感,学习从未如此快乐 \(i)"
            homeModel.count = i
            models.append(homeModel)
        }
        adapter.models = models
        // 刷新数据
        SendMsg<HomePresenterDelegate>.send(view, #selector(HomePresenterDelegate.reloadView))
    }
}
