//
//  WJBaseViewController.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

class WJBaseViewController: UIViewController {
    
    private var rootContext: CDDContext!
    private var mvpEnabled = false
    
    // context/presenter/view/interactor 建立绑定关系
    public func registMVP(name: String, prefix: String = ""/** 类名前缀 */) {
        mvpEnabled = true

        rootContext = CDDContext() // strong
        context = rootContext // weak
        
        let projectName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        // presenter
        if let presenterClass = NSClassFromString(projectName+"."+prefix+name+"Presenter") as? CDDPresenter.Type {
            context.presenter = presenterClass.init()
            context.presenter.context = context
        }
        
        // interactor
        if let interactorClass = NSClassFromString(projectName+"."+prefix+name+"Interactor") as? CDDInteractor.Type {
            context.interactor = interactorClass.init()
            context.interactor.context = context
        }
        
        // view
        if let viewClass = NSClassFromString(projectName+"."+prefix+name+"View") as? CDDView.Type {
            context.view = viewClass.init()
            context.view.context = context
        }
        
        //build relation
        context.presenter.view = context.view
        context.presenter.baseController = self
        context.interactor.baseController = self
        context.view.presenter = context.presenter
        context.view.interactor = context.interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if mvpEnabled {
            context.view.frame = view.bounds
            view = context.view
        }
        debugPrint("did load viewController: \(type(of: self))")
    }
    
    override func didReceiveMemoryWarning() {
        debugPrint("\(self) - 内存警告")
//        MyKingfisherCache.clearKingfisherImageCache()
//        MyKingfisherCache.cancelAll()
    }
    
    @objc func refreshData() {
        debugPrint("刷新")
    }
    
    deinit {
        debugPrint("release viewController: \(type(of: self))")
        NotificationCenter.default.removeObserver(self)
    }
}

// 侧滑手势禁用启用
extension WJBaseViewController {
    func popGestureClose() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func popGestureOpen() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
