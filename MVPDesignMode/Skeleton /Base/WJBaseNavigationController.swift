//
//  WJBaseNavigationController.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

class WJBaseNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        navigationBar.isTranslucent = false
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.shadowImage = UIImage()
        if #available(iOS 13.0, *) {
            let barApp = UINavigationBarAppearance()
            barApp.backgroundColor = .white
            navigationBar.scrollEdgeAppearance = barApp // 可滑动界面配置
            navigationBar.standardAppearance = barApp // 普通页面配置
        } else {
            // Fallback on earlier versions
        }
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}

extension WJBaseNavigationController
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = creatBackBarButton()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if viewControllers.count > 1 {
            topViewController?.hidesBottomBarWhenPushed = false
        }
        return super.popToRootViewController(animated: animated)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if viewControllers.count <= 1 {
            return false
        }
        return true
    }
    
    private func creatBackBarButton() -> UIBarButtonItem {
        let backBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "navi_back_black"), style: .plain, target: self, action: #selector(backBarButtonAction(_:)))
        return backBarButton
    }
    
    @objc private func backBarButtonAction(_ sender: UIBarButtonItem) {
        //NotificationCenter.default.post(name: NetToolCancelNotificationName, object: nil)
        _ = popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            hideTabBar(viewController.hidesBottomBarWhenPushed)
        } else {
            showTabBar(viewController.hidesBottomBarWhenPushed)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationController.topViewController?.transitionCoordinator?.notifyWhenInteractionChanges({ (context) in
            //返回成功false,未返回true
            if !context.isCancelled {
                //NotificationCenter.default.post(name: NetToolCancelNotificationName, object: nil)
            }
        })
    }
}

extension WJBaseNavigationController {
    
    private func hideTabBar(_ hidesBottomBarWhenPushed: Bool) {
        guard let tabBar = tabBarController?.tabBar else {return}
        guard hidesBottomBarWhenPushed else { return }
        UIView.animate(withDuration: 0.35) {
            var tabFrame = tabBar.frame
            tabFrame.origin.y = UIScreen.main.bounds.size.height + tabFrame.size.height
            tabBar.frame = tabFrame
        }
    }
    
    
    private func showTabBar(_ hidesBottomBarWhenPushed: Bool) {
        guard let tabBar = tabBarController?.tabBar else {return}
        guard !hidesBottomBarWhenPushed else { return }
        UIView.animate(withDuration: 0.5) {
            var tabFrame = tabBar.frame
            tabFrame.origin.y = UIScreen.main.bounds.size.height - tabFrame.height
            tabBar.frame = tabFrame
        }
    }
}
