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
    var original_price: String
    var productId: String?
    
    required init?(_ map: Map) {
        original_price = ""
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
        products <- map["Products"]

    }
}

class CategoryModel: BaseModel, Mappable {
    
    var categoryId: String?
    var name: String?
    var order: Int?
    var parentId: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        categoryId <- map["Category.id"]
        name <- map["Category.name"]
        order <- map["Category.order"]
        parentId <- map["Category.parentId"]
    }
}

class CategoryListModel: BaseModel, Mappable {
    var categories: [CategoryModel]?
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        categories <- map["categories"]
        
    }
}
