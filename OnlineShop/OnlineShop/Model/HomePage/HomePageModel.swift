//
//  HomePageModel.swift
//  OnlineShop
//
//  Created by PerryChen on 3/1/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductModel: BaseModel,  Mappable{
    
    var create_time: String?
    var deleted: Int?
    var desc: String?
    var imgUrl: String?
    var name: String?
    var original_price: Double?
    var productId: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        productId <- map["Product.id"]
        create_time <- map["Product.create_time"]
        deleted <- map["Product.deleted"]
        desc <- map["Product.description"]
        imgUrl <- map["Product.imgUrl"]
        name <- map["Product.name"]
        original_price <- map["Product.original_price"]
    }
}

class ProductListModel: BaseModel,  Mappable {
    var products: [ProductModel]?
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        products <- map["products"]

    }
}
