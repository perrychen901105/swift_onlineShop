//
//  ProductDetailViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/7/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import AlamofireImage
import JGProgressHUD

class ProductDetailViewController: UIViewController {

    var productId: Int?
    
    var homeViewModel: RequestHomePage?
    
    var managedContext: NSManagedObjectContext?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSpec: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var imgViewContent: UIImageView!
    
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
        self.lblPrice.text = "￥ \((self.homeViewModel?.productDetail.original_price)!)"
        self.lblSpec.text = self.homeViewModel?.productDetail.spec
        if self.homeViewModel?.productDetail.imgUrl.characters.count > 0 {
            Alamofire.request(.GET, (self.homeViewModel?.productDetail.imgUrl)!).responseImage(completionHandler: { (response) in
                if let image = response.result.value {
                    self.imgViewContent.image = image
                }
            })
        }
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
                cart.price = Double(detail.original_price)!
                cart.spec = detail.spec
                self.managedContext!.insertObject(cart)
                try self.managedContext!.save()
                
                let loading = JGProgressHUD(style: .Light)
                loading.textLabel.text = "添加购物车成功"
                loading.indicatorView = JGProgressHUDSuccessIndicatorView()
                loading.showInView(self.view)
                loading.dismissAfterDelay(0.5)
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
