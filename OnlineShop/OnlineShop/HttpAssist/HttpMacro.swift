//
//  HttpMacro.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

let HTTPDomain: String = "http://127.0.0.1/cakephp/"

enum HttpMacro: String {
    case ProductList
    func combineString(str: String) -> String! {
        return HTTPDomain + str
    }
    
    func getRequestURL() -> String {
        switch self {
        case .ProductList:
            return combineString("products")
        }
    }
}
