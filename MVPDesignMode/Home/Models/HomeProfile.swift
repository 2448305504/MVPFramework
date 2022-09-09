//
//  HomeModel.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/7.
//

import UIKit

class HomeProfile: WJBaseModel {
    // 品牌id
    var brandId = ""
    // 品牌名称
    var brandName = ""
    // 品牌logo
    var logoImg = ""
    // 品牌图片
    var bannerImg = ""
    // 是否为五包品牌   1是，0否
    var isFiveServices = false
    
    var flagShip = ""
    var letter = ""
    var count = 0 // 商品数量
}
