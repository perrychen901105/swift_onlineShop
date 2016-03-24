//
//  ShoppingCartViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit
import CoreData
import JGProgressHUD
import Alamofire
import AlamofireImage

class ShoppingCartViewController: UIViewController {

    var managedContext: NSManagedObjectContext?
    var cartListArr: [ShoppingCart]?
    var curShipAddress: OrderAddressModel?
    var orderViewModel: RequestOrder?
    
    @IBOutlet weak var tbViewContent: UITableView!
    
    @IBOutlet weak var lblShipAddress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderViewModel = RequestOrder()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.navigationItem.title = "购物车"
        
        self.managedContext = appDelegate.managedObjectContext
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getCartList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCartList() {
        let request = NSFetchRequest(entityName: "ShoppingCart")
        do {
            let results = try self.managedContext?.executeFetchRequest(request) as! [ShoppingCart]
            if results.count > 0 {
                self.cartListArr = results
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    @IBAction func submitCartAction(sender: AnyObject) {
        if self.curShipAddress?.addressId == nil {
            let loading = JGProgressHUD(style: .Dark)
            loading.textLabel.text = "请选择收货地址!"
            loading.indicatorView = JGProgressHUDErrorIndicatorView()
            loading.showInView(self.view)
            loading.dismissAfterDelay(0.5)
            return
        }
        let glManager: GlobalManager = GlobalManager.sharedInstance
        if glManager.curUser?.user_id == nil {
            print("please login")
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            })
        } else {
            let alertController: UIAlertController = UIAlertController(title: "是否提交订单", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (sender) -> Void in
                if self.cartListArr?.count == 0 {
                    return
                }
                let allPrices = self.cartListArr?.reduce(0, combine: { (price, model:ShoppingCart) -> Float in
                    price+(model.price?.floatValue)!
                })
                let allIds: Array = (self.cartListArr?.map({ (model) -> String in
                    return (model.productId?.stringValue)!
                }))!
                let strIds = allIds.joinWithSeparator("_")
                let paras: [String: AnyObject] = ["price": String(format: "%f", allPrices!), "userId": (glManager.curUser?.user_id)!, "proId":strIds, "addressId": (self.curShipAddress?.addressId)!]
                self.orderViewModel?.saveOrder(paras, success: { () -> Void in
                    let loading = JGProgressHUD(style: .Light)
                    loading.textLabel.text = "提交成功"
                    loading.indicatorView = JGProgressHUDSuccessIndicatorView()
                    loading.showInView(self.view)
                    loading.dismissAfterDelay(0.5)
                    let fetchRequest = NSFetchRequest(entityName: "ShoppingCart")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    
                    do {
                        try self.managedContext?.executeRequest(deleteRequest)
                        self.cartListArr?.removeAll()
                        self.tbViewContent.reloadData()
                    } catch let error as NSError {
                        print("Could not delete \(error), \(error.userInfo)")
                    }
                    }, failure: { (str) -> Void in
                        
                })
            })
            alertController.addAction(alertAction)

            let alertCancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (sender) -> Void in
                
            })
            alertController.addAction(alertCancelAction)
            self.presentViewController(alertController, animated: true, completion: { () -> Void in
                
            })
        }
    }
    
    @IBAction func actionChooseAddress(sender: UIButton) {
        let glManager: GlobalManager = GlobalManager.sharedInstance
        if glManager.curUser?.user_id == nil {
            print("please login")
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            })
        } else {
            let vcAddressList: AddressListViewController = UIStoryboard(name: "OrderPage", bundle: nil).instantiateViewControllerWithIdentifier("AddressListViewController") as! AddressListViewController
            vcAddressList.block = { s in
                if let modelAddress:OrderAddressModel = s {
                    self.curShipAddress = modelAddress
                    self.lblShipAddress.text = self.curShipAddress?.address
                }
            }
            vcAddressList.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vcAddressList, animated: true)
        }
    }
    
    func removeCart(sender: UIButton) {
        print(sender.tag)
//        let fetchRequest = NSFetchRequest(entityName: "ShoppingCart")
        let model: ShoppingCart = self.cartListArr![sender.tag]
        do {
            self.managedContext!.deleteObject(model)
            try self.managedContext!.save()
            self.cartListArr?.removeAtIndex(sender.tag)
            self.tbViewContent.reloadData()
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueProductDetail" {
            let vcProduct = segue.destinationViewController as! ProductDetailViewController
            let cell :ShoppingCartCell = (sender as? ShoppingCartCell)!
            let idxPath : NSIndexPath = self.tbViewContent.indexPathForCell(cell)!
            let model: ShoppingCart = self.cartListArr![idxPath.row]
            vcProduct.productId = Int(model.productId!)
            vcProduct.navigationItem.title = model.name
        }
    }
}

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingCartCell") as! ShoppingCartCell

        let cart = self.cartListArr![indexPath.row] 
        cell.lblName.text = cart.name
        cell.lblPrice.text = "￥ \((cart.price?.stringValue)!)"
        cell.lblSpec.text = cart.spec
        if cart.imgUrl!.characters.count > 0 {
            Alamofire.request(.GET, (cart.imgUrl)!).responseImage(completionHandler: { (response) in
                if let image = response.result.value {
                    cell.imgView.image = image
                }
            })
        }
        cell.btnRemoveCart.tag = indexPath.row
        cell.btnRemoveCart.addTarget(self, action: #selector(ShoppingCartViewController.removeCart(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let carts = self.cartListArr {
            return carts.count
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
