//
//  HomeRequestAssist.swift
//  OnlineShop
//
//  Created by PerryChen on 3/1/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

protocol HomeRequestProtocol: HTTPRootProtocol {
    func getAllProductList(params: [String: AnyObject]?, success:(resObj: String) -> Void, failure:(resMsg: String) -> Void)
}

extension HomeRequestProtocol  {
    /**
     获取所有商品列表
     
     - parameter params: 参数
     */
    
    
    func getAllProductList(params: [String: AnyObject]?, success:(resObj: ProductListModel) -> Void, failure:(resMsg: String) -> Void) {
        self.getRequestForData(HttpMacro.getRequestURL(.ProductList)(),
            params: params,
            success: { (responseObj) -> Void in
                
            },
            failure: { (responseStr) -> Void in
                
        })
    }
//        self.getRequestForData(HttpMacro.getRequestURL(.ProductList)(), params: params, success: { (responseObj) -> Void in
//            guard let responseObj = responseObj else {
//                print("error")
//                return
//            }
////            if let productList = Mapper<ProductListModel>().map(responseObj) {
////                //                success(resObj: productList)
////            } else {
////                //                failure(resMsg: "no products")
////            }
////            }, failure: <#T##(errorObj: String) -> Void#>)
////        
////        self.getRequestForData(HttpMacro.getRequestURL(.ProductList)(), params: params, success: { (responseObj: AnyObject?) -> Void in
////
////            }) { (errorObj) -> Void in
////                failure(resMsg: errorObj)
//        }
//    }
}