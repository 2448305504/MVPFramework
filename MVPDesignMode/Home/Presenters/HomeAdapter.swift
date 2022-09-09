//
//  HomeAdapter.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

// 适配器
class HomeAdapter: WJBaseAdapter {
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
//        cell.homeProfile = models[indexPath.row] as? HomeProfile
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @objc private func tableView(_ tableView: UITableView, cellFor data: HomeProfile) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.homeProfile = data
        return cell
    }
}
