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
    var phone: String
    var receiver: String
    
    
    required init?(_ map: Map) {
        phone = ""
        receiver = ""
    }
    
    func mapping(map: Map) {
        addressId <- map["order_addresses.id"]
        address <- map["order_addresses.full_address"]
        phone <- map["order_addresses.phone_number"]
        receiver <- map["order_addresses.receiver"]
    }
}

class OrderListModel: BaseModel, Mappable {
    var address: String?
    var phone: String
    var receiver: String
    var orderId: String?
    var orderTime: String
    var totalPrice: String?
    
    required init?(_ map: Map) {
        phone = ""
        receiver = ""
        orderTime = ""
    }
    
    func mapping(map: Map) {
        address <- map["Address.full_address"]
        phone <- map["Address.phone_number"]
        receiver <- map["Address.receiver"]
        orderId <- map["Order.id"]
        orderTime <- map["Order.order_time"]
        totalPrice <- map["Order.total_price"]
    }
}

class OrderProductModel: BaseModel, Mappable {
    var imgUrl: String
    var productName: String
    var price: String
    var productId: String
    
    required init?(_ map: Map) {
        imgUrl = ""
        productName = ""
        price = ""
        productId = ""
    }
    
    func mapping(map: Map) {
        productId <- map["products.id"]
        productName <- map["products.name"]
        imgUrl <- map["products.imgUrl"]
        price <- map["products.original_price"]
    }
}

