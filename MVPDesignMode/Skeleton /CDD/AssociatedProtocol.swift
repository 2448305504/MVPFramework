//
//  AssociatedProtocol.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

protocol AssociatedProtocol {}

extension AssociatedProtocol {
    func setAssociated(key: Selector, value: Any?, policy: objc_AssociationPolicy) {
       let p = unsafeBitCast(key, to: UnsafeRawPointer.self)
       objc_setAssociatedObject(self, p, value, policy)
   }
   
   func getAssociated<T>(key: Selector) -> T? {
       let p = unsafeBitCast(key, to: UnsafeRawPointer.self)
       return objc_getAssociatedObject(self, p) as? T
   }
}
