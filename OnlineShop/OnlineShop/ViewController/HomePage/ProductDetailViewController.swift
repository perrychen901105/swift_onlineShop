//
//  ProductDetailViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/7/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailViewController: UIViewController {

    var productId: Int?
    
    var homeViewModel: RequestHomePage?
    
    var managedContext: NSManagedObjectContext?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = RequestHomePage()
        if let productId = self.productId {
            self.getProductDetail(productId)
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.managedContext = appDelegate.managedObjectContext
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductDetail(productId: Int) {
        weak var wself = self
        if let viewModel = self.homeViewModel {
            viewModel.getProductDetail(["productId":productId], success: { () -> Void in
                wself?.refreshUI()
                }, failure: { (str) -> Void in
                    
            })
        }
    }

    func refreshUI() {
        self.lblTitle.text = self.homeViewModel?.productDetail.name
        self.tvContent.text = self.homeViewModel?.productDetail.desc
        
        let request = NSFetchRequest(entityName: "ShoppingCart")
        do {
            let results = try self.managedContext?.executeFetchRequest(request)
            print("fetch results is \(results)")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addToCart(sender: UIButton) {
        
        if let detail = self.homeViewModel?.productDetail {
            let dogEntity = NSEntityDescription.entityForName("ShoppingCart",
                inManagedObjectContext: self.managedContext!)
            
            do {
                let cart: ShoppingCart = ShoppingCart(entity: dogEntity!, insertIntoManagedObjectContext: self.managedContext)
                cart.desc = detail.desc
                cart.productId = Int((detail.productId)!)
                cart.name = detail.name
                cart.imgUrl = detail.imgUrl
                cart.createTime = NSDate()
                cart.price = Double(detail.original_price!)
                
                self.managedContext!.insertObject(cart)
                try self.managedContext!.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
