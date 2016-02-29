//
//  HttpRequestAssist.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

protocol HomeRequestProtocol: HTTPRootProtocol {
    func getAllProductList(params: [String: AnyObject]?, success:(resObj: String) -> Void, failure:(resMsg: String) -> Void)
}

extension HomeRequestProtocol {
    /**
     获取所有商品列表
     
     - parameter params: 参数
     */
    func getAllProductList(params: [String: AnyObject]?, success:(resObj: String) -> Void, failure:(resMsg: String) -> Void) {
        
        self.getRequestForData(HttpMacro.getRequestURL(.ProductList)(), params: params, success: { (responseObj: AnyObject) -> Void in
            success(resObj: responseObj as! String);
            }) { (errorObj) -> Void in
                
        }
    }
}
