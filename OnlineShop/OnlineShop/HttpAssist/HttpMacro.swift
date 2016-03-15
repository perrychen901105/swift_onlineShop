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
    case ProductList, CategoryList, ProductDetail, RegisterUser, LoginUser
    func combineString(str: String) -> String! {
        return HTTPDomain + str
    }
    
    func getRequestURL() -> String {
        switch self {
        case .ProductList:
            return combineString("products")
        case .CategoryList:
            return combineString("categories")
        case .ProductDetail:
            return combineString("products/getProductDetail")
        case .RegisterUser:
            return combineString("userInfos/register")
        case .LoginUser:
            return combineString("userInfos/login")
        }
        
    }
    
    /**
    public $default = array(
    'datasource' => 'Database/Mysql',
    'persistent' => false,
    'host' => 'localhost',
    'login' => 'root',
    'password' => 'root',
    'database' => 'onlineshop',
    'prefix' => '',
    'schema' => '',
    'encoding' => 'utf8',
    );
    
    
    You can disable the debug feature by turning debug to 0 in the app\Config\core.php file
    
    Configure::write('debug', 0);
    **/
}
