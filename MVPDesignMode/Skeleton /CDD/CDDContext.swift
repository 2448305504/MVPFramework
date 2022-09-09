//
//  CDDContext.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/6.
//

import UIKit

class CDDPresenter: NSObject {
    public weak var baseController: UIViewController!
    public weak var view: CDDView!
     public weak var adapter: WJBaseAdapter! //for tableview adapter (id)
    required override init() {}
}

class CDDInteractor: NSObject {
    public weak var baseController: UIViewController!
    required override init() {}
}

class CDDView: UIView {
    public weak var presenter: CDDPresenter!
    public weak var interactor: CDDInteractor!
    
    required init() {
        super.init(frame: .zero)
    }
    
    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit { context = nil }
}

//Context bridges everything automatically, no need to pass it around manually
class CDDContext: NSObject {
    public var presenter: CDDPresenter!
    public var interactor: CDDInteractor!
    public var view: CDDView! //view holds strong reference back to context
}
