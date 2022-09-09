//
//  WJBaseAdapter.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

@objc protocol WJBaseAdapterDelegate: NSObjectProtocol {
    @objc optional func didSelect(cellData: Any)
    @objc optional func delete(cellData: Any)
    @objc optional func willDisplay(cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

@objc protocol WJBaseAdapterScrollDelegate: NSObjectProtocol {
    @objc optional func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidEndDragging(_ scrollView: UIScrollView)
}

@objc protocol WJBaseAdapterPullUpDelegate: NSObjectProtocol {
    @objc optional func loadMore()
}

class WJBaseAdapter: NSObject {
    public var models: [WJBaseModel] = [] // 数据
    
    public weak var adapterDelegate: WJBaseAdapterDelegate?
    public weak var adapterScrollDelegate: WJBaseAdapterScrollDelegate?
    public weak var adapterPullUpDelegate: WJBaseAdapterPullUpDelegate?
    
    public func getTableContentHeight() -> CGFloat { return 0 }
    
    public func refreshCell(by data: Any, tableView: UITableView) {}
}

extension WJBaseAdapter: UITableViewDataSource, UITableViewDelegate {
    // UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > models.count-1 { return UITableViewCell() }
        let data = models[indexPath.row]
        let sel = NSSelectorFromString("tableView:cellFor:")
        guard let cell = perform(sel, with: tableView, with: data).takeUnretainedValue() as? UITableViewCell else { return UITableViewCell() }
        return cell
    }
    
    // UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > models.count-1 { return }
        tableView.deselectRow(at: indexPath, animated: false)
        let cellData = models[indexPath.row]
        if let adapterDelegate = adapterDelegate {
            adapterDelegate.didSelect?(cellData: cellData)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > models.count-1 { return }
        
        if let adapterPullUpDelegate = adapterPullUpDelegate {
            if tableView.style == .grouped {
                if !models.isEmpty, indexPath.row == models.count-1 {
                    adapterPullUpDelegate.loadMore?()
                }
            } else if tableView.style == .plain {
                if models.count > 4 && indexPath.row == models.count-4 {
                    adapterPullUpDelegate.loadMore?()
                }
            }
        }
        
        if let adapterDelegate = adapterDelegate {
            adapterDelegate.willDisplay?(cell: cell, forRowAt: indexPath)
        }
    }
    
    // UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let adapterScrollDelegate = adapterScrollDelegate else { return }
        adapterScrollDelegate.scrollViewWillBeginDragging?(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let adapterScrollDelegate = adapterScrollDelegate else { return }
        adapterScrollDelegate.scrollViewDidScroll?(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView) {
        guard let adapterScrollDelegate = adapterScrollDelegate else { return }
        adapterScrollDelegate.scrollViewDidEndDragging?(scrollView)
    }
}
