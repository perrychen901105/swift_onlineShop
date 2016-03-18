//
//  OrderAddressModel.swift
//  OnlineShop
//
//  Created by PerryChen on 3/18/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

import ObjectMapper

class OrderAddressModel: BaseModel ,Mappable{
    var addressId: String?
    var address: String?
    var phone: String?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        addressId <- map["order_addresses.id"]
        address <- map["order_addresses.full_address"]
        phone <- map["order_addresses.phone_number"]
    }
}
