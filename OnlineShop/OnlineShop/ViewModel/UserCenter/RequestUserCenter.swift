//
//  RequestUserCenter.swift
//  OnlineShop
//
//  Created by PerryChen on 3/11/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RequestUserCenter {
    var userModel : UserModel!
}

extension RequestUserCenter {
    /**
      注册
     
     */
    func userRegister(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.RegisterUser)(), parameters: parameters).responseJSON { (resObj) -> Void in
            
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                print("the obj is + \(resObj.result.value!["data"])")
                if let userModel = Mapper<UserModel>().map(resObj.result.value!["data"]) {
                    self.userModel = userModel
                }
                
                success()
            } else {
                
            }
        }
    }
    
    /**
    *  登录
    */
    func loginAction(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.LoginUser)(), parameters: parameters).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                print("the obj is + \(resObj.result.value!["data"])")
                if let userModel = Mapper<UserModel>().map(resObj.result.value!["data"]) {
                    self.userModel = userModel
                }
                success()
            } else {
                
            }
        }
    }
    
    
}
