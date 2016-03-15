//
//  UserCenterModel.swift
//  OnlineShop
//
//  Created by PerryChen on 3/15/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

import ObjectMapper

class UserModel: BaseModel,  Mappable{
    
    var user_id: String?
    var name: String?
    var phone: String?

    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        user_id <- map["User.id"]
        name <- map["User.user_name"]
        phone <- map["User.phone_number"]
    }
}

