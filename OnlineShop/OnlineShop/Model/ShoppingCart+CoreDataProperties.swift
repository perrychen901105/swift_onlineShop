//
//  ShoppingCart+CoreDataProperties.swift
//  
//
//  Created by PerryChen on 3/8/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ShoppingCart {

    @NSManaged var productId: NSNumber?
    @NSManaged var name: String?
    @NSManaged var price: NSNumber?
    @NSManaged var desc: String?
    @NSManaged var createTime: NSDate?
    @NSManaged var imgUrl: String?

}
