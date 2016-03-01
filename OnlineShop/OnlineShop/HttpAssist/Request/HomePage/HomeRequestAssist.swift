//
//  HomeRequestAssist.swift
//  OnlineShop
//
//  Created by PerryChen on 3/1/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation
import ObjectMapper

protocol HomeRequestProtocol: HTTPRootProtocol {
    func getAllProductList(params: [String: AnyObject]?, success:(resObj: String) -> Void, failure:(resMsg: String) -> Void)
}

extension HomeRequestProtocol {
    /**
     获取所有商品列表
     
     - parameter params: 参数
     */
    func getAllProductList(params: [String: AnyObject]?, success:(resObj: String) -> Void, failure:(resMsg: String) -> Void) {
        
        self.getRequestForData(HttpMacro.getRequestURL(.ProductList)(), params: params, success: { (responseObj: AnyObject?) -> Void in
            guard let responseObj = responseObj else {
                print("error")
                return
            }
//            print(responseObj)
            var productS = Mapper<ProductModel>().map(responseObj)
            print(productS?.name)
            var productList = Mapper<ProductListModel>().map(responseObj)
            
            if let productList = productList {
                print(productList.products?.description)
                for product in productList.products! {
//                    print(product.desc)
//                    print(product.create_time)
                    print(product.name)
                }
            }
            }) { (errorObj) -> Void in
                
        }
    }
}