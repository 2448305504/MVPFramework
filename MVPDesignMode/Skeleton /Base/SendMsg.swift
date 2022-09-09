//
//  SendMsg.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/8.
//

/// 让对象做某事
// ps: 让objc继承自T类型，去调用selector
struct SendMsg<T> {
    // 方法调用 - 无返回值
    static func send(_ responder: AnyObject, // 响应者
                     _ selector: Selector, // 协议方法
                     _ argv: Any? = nil) { // 参数
        guard responder is T else { debugPrint("\(type(of: responder))不是\(T.self)类型"); return }
        responder.performSelector(onMainThread: selector, with: argv, waitUntilDone: false)
    }
    
    // 方法调用 - 有返回值
    @discardableResult
    static func send_R<U>(_ responder: AnyObject, // 响应者
                          _ selector: Selector, // 协议方法
                          _ returnType: U.Type, // 返回值类型
                          _ argv1: Any? = nil,  // 参数1/2
                          _ argv2: Any? = nil) -> U? {
        guard responder is T else { debugPrint("\(type(of: responder))不是\(T.self)类型"); return nil }
        return unsafeBitCast(responder.perform(selector, with: argv1, with: argv2), to: U.self)
    }
}
