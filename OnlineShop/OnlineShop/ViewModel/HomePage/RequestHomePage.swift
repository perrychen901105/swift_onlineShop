//
//  RequestHomePage.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

struct RequestHomePage: HomeRequestProtocol {
    
    /**
     获取全部的商品列表
     
     - parameter count: 商品个数
     */
    func getProductsList(count: Int) {
        self.getAllProductList(nil, success: { (resObj: String) -> Void in
            
            }) { (resMsg) -> Void in
                print(resMsg)
        }
    }
}
