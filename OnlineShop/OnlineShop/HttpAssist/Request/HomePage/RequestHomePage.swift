//
//  RequestHomePage.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

class RequestHomePage: HomeRequestProtocol {
    func getProductsList(count: Int) {
        self.getAllProductList(nil, success: { (resObj: String) -> Void in
            print("11" + resObj)
            }) { (resMsg) -> Void in
                
        }
    }
}
