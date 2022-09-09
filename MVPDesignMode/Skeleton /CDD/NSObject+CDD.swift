//
//  NSObject+CDD.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/6.
//

import UIKit

extension NSObject: AssociatedProtocol {
    @objc var context: CDDContext! {
        set {
            setAssociated(key: #selector(setter: context), value: newValue, policy: .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            var curContext: CDDContext? = getAssociated(key: #selector(setter: self.context))
            if curContext == nil && isKind(of: UIView.self) {
                // try get from superview, lazy get
                let view = self as! UIView
                var superview = view.superview
                while superview != nil {
                    if superview!.context != nil {
                        curContext = superview!.context;
                        break
                    }
                    superview = superview!.superview;
                }
                
                if curContext != nil {
                    self.context = curContext
                }
            }
            return curContext
        }
    }
}
