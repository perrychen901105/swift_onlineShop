//
//  RequestHomePage.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

//HomeRequestProtocol
class RequestHomePage {
    var products: ProductListModel?
    var categories: [CategoryModel]!
}

extension RequestHomePage {
    /**
     获取全部的商品列表
     
     - parameter count: 商品个数
     */
    func getProductsList(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.GET, HttpMacro.getRequestURL(.ProductList)(), parameters: nil).responseJSON { (resObj) -> Void in
            //            print("the obj is + \(resObj.result.value)")
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                if let productList = Mapper<ProductListModel>().map(resObj.result.value!["data"]) {
                    self.products = productList
                }
            } else {
                
            }
        }
    }
    
    /**
     获取全部的类别列表
     
     - parameter parameters:
     - parameter success:
     - parameter failure:
     */
    func getCategoryList(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.GET, HttpMacro.getRequestURL(.CategoryList)(), parameters: nil).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                if let categoryList = Mapper<CategoryListModel>().map(resObj.result.value!["data"]) {
                    self.categories = categoryList.categories
                    success()
                }
            } else {
                
            }
        }
    }
}
