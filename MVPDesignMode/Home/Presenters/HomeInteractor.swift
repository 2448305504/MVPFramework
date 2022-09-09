//
//  HomeInteractor.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

// 交互器
class HomeInteractor: CDDInteractor, HomePresenterDelegate {
    
    func gotoLiveStream() {
        baseController.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
