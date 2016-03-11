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
    
}

extension RequestUserCenter {
    /**
      注册
     
     */
    func userRegister(parameters: [String: AnyObject], success:()->Void, failure:(str: String) -> Void) {
        Alamofire.request(.POST, HttpMacro.getRequestURL(.ProductList)(), parameters: parameters).responseJSON { (resObj) -> Void in
            //            print("the obj is + \(resObj.result.value)")
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                if let productList = Mapper<ProductListModel>().map(resObj.result.value!["data"]) {
  
                    success()
                }
            } else {
                
            }
        }
    }
}
