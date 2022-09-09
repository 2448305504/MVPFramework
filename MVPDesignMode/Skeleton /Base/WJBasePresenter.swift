//
//  WJBasePresenter.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

class WJBasePresenter: CDDPresenter {
    
    private var eventMap: [String: String] = [:]
    
    // DB Notification methods
    public func observeTable(_ table: String, event: String, selector: Selector) {
        let eventKey = table+"_"+event
        eventMap[eventKey] = NSStringFromSelector(selector)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: table), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(detectDBChange(_:)), name: NSNotification.Name(rawValue: table), object: nil)
    }
    
    public func unobserveTable(_ table: String, event: String) {
        let eventKey = table+"_"+event
        eventMap.removeValue(forKey: eventKey)
    }
    
    public func postLoading() {
        if self.view != nil {
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
    }

    public func hideLoading() {
        if self.view != nil {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }
    
    public func postImageToast(_ toast: String) {
        
    }
    
    public func postToast(_ toast: String) {
        
    }
    
    // 识别到数据变化
    @objc private func detectDBChange(_ noti: NSNotification) {
        guard let info = noti.userInfo else { return }
        guard let table = info["tanle"] as? String, let event = info["event"] as? String, let data = info["data"] else { return }
        let eventKey = table+"_"+event
        guard let selectorName = eventMap[eventKey], !selectorName.isEmpty else {return}
        performSelector(onMainThread: NSSelectorFromString(selectorName), with: data, waitUntilDone: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
