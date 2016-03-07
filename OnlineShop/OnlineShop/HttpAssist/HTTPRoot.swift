//
//  HTTPRoot.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation
import Alamofire

protocol HTTPRootProtocol {
    func requestForData(url: String!, params:[String: AnyObject]?, success:(responseObj: AnyObject?)->Void, failure:(errorObj: AnyObject)->Void)
    func getRequestForData(url: String!, params:[String: AnyObject]?, success:(responseObj: AnyObject?)->Void, failure:(errorObj: String)->Void)
    func postRequestForData(url: String!, params:[String: AnyObject]?, success:(responseObj: AnyObject?)->Void, failure:(errorObj: AnyObject)->Void)
}
extension HTTPRootProtocol {
    func requestForData(url: String!, params: [String : AnyObject]?, success: (responseObj: AnyObject?) -> Void, failure: (errorObj: AnyObject) -> Void) {
        print("1")
    }
    
    func getRequestForData(url: String!, params:[String: AnyObject]?, success:(responseObj: AnyObject?)->Void, failure:(errorObj: String)->Void) {
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { (resObj) -> Void in
            guard let resValue = resObj.result.value else {
                return
            }
            if Int(resValue["success"] as! NSNumber) == 0{
                success(responseObj: resObj.result.value!["data"])
            } else {
                failure(errorObj: resValue["message"] as! String)
            }
            
        }
    }
    
    func postRequestForData(url: String!, params:[String: AnyObject]?, success:(responseObj: AnyObject?)->Void, failure:(errorObj: AnyObject)->Void) {
        
    }
}
