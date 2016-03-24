//
//  RequestOrder.swift
//  OnlineShop
//
//  Created by PerryChen on 3/18/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RequestOrder {
    var arrAddress: [OrderAddressModel] = []
    var arrOrderList: [OrderListModel] = []
    var arrOrderDetail: [OrderProductModel] = []
}

extension RequestOrder {
    /**
     *  获取全部收货地址
     */
    func getAllAddress(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.GetAllAddress)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                self.arrAddress.removeAll()
                let arrOri = resObj.result.value!["data"] as! NSArray
                let sum: Int = arrOri.count
                for i in 0 ..< sum {
                    let model = arrOri[i]
                    if let userModel = Mapper<OrderAddressModel>().map(model) {
                        self.arrAddress.append(userModel)
                    }
                }
                success()
            } else {
            }
        }
    }
    
    /**
    *  添加收获地址
    */
    func addAddress(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.AddAddress)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                success()
            } else {
            }
        }
    }
    
    /**
    *  删除收获地址
    */
    func removeAddress(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.RemoveAddress)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                success()
            } else {
            }
        }
    }
    
    /**
    *  保存订单
    */
    func saveOrder(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.SaveOrder)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                success()
            } else {
            }
        }
    }
    
    /**
    *  获取订单列表
    */
    func getOrderList(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.GET, HttpMacro.getRequestURL(.GetOrderList)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                self.arrOrderList.removeAll()
                let arrOri = resObj.result.value!["data"] as! NSArray
                let sum: Int = arrOri.count
                for i in 0 ..< sum {
                    let model = arrOri[i]
                    if let orderModel = Mapper<OrderListModel>().map(model) {
                        self.arrOrderList.append(orderModel)
                    }
                }
                success()
            } else {
            }
        }
    }
    
    /**
     *  获取订单详情
     */
    func getOrderDetail(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.GET, HttpMacro.getRequestURL(.GetOrderDetail)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                self.arrOrderDetail.removeAll()
                let arrOri = resObj.result.value!["data"] as! NSArray
                let sum: Int = arrOri.count
                for i in 0 ..< sum {
                    let model = arrOri[i]
                    if let orderModel = Mapper<OrderProductModel>().map(model) {
                        self.arrOrderDetail.append(orderModel)
                    }
                }
                success()
            } else {
            }
        }
    }
    
    /**
     *  完成订单接口
     */
    func completeOrder(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) -> Void {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.CompleteOrder)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                self.arrOrderDetail.removeAll()
                success()
            } else {
            }
        }
    }
}
