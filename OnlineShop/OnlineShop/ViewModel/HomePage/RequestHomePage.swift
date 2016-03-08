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
    var products: [ProductModel]!
    var categories: [CategoryModel]!
    var productDetail: ProductModel!
}

extension RequestHomePage {
    /**
     获取全部的商品列表
     
     - parameter count: 商品个数
     - parameter categoryId: 类别id
     */
    func getProductsList(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.GET, HttpMacro.getRequestURL(.ProductList)(), parameters: parameters).responseJSON { (resObj) -> Void in
            //            print("the obj is + \(resObj.result.value)")
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                if let productList = Mapper<ProductListModel>().map(resObj.result.value!["data"]) {
                    self.products = productList.products
                    success()
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
        Alamofire.request(.GET, HttpMacro.getRequestURL(.CategoryList)(), parameters: parameters).responseJSON { (resObj) -> Void in
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
    
    func getProductDetail(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.GET, HttpMacro.getRequestURL(.ProductDetail)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                print("the value is \(resObj.result.value)")
                if let product = Mapper<ProductModel>().map(resObj.result.value!["data"]) {
                    self.productDetail = product
                    success()
                }
            } else {
                
            }
        }
    }
}
