//
//  GlobalManager.swift
//  OnlineShop
//
//  Created by PerryChen on 3/9/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import Foundation

class GlobalManager {
    static let sharedInstance = GlobalManager()
    private init() {}
    
    var userId: NSString?
}
