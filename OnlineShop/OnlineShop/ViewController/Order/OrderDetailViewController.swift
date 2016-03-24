//
//  OrderDetailViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/23/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class OrderDetailViewController: UIViewController {

    var orderListViewModel: RequestOrder?
    var orderId: NSString?
    
    @IBOutlet weak var tbViewContent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderListViewModel = RequestOrder()
        self.getOrderDetail()
        self.navigationItem.title = "订单详情"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getOrderDetail() -> Void {
        if let modelOrder = self.orderListViewModel, orderId = self.orderId {
            modelOrder.getOrderDetail(["orderID":orderId], success: { 
                self.tbViewContent.reloadData()
                }, failure: { (str) in
                    
            })
        }
    }
    
    @IBAction func actionCompleteOrder(sender: UIButton) {
        let alertController: UIAlertController = UIAlertController(title: "是否确认订单已完成", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (sender) -> Void in
            if let modelOrder = self.orderListViewModel, orderId = self.orderId {
                modelOrder.completeOrder(["orderID":orderId], success: {
                    self.tbViewContent.reloadData()
                    self.navigationController?.popViewControllerAnimated(true)
                    }, failure: { (str) in
                        
                })
            }
        })
        alertController.addAction(alertAction)
        
        let alertCancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (sender) -> Void in
            
        })
        alertController.addAction(alertCancelAction)
        self.presentViewController(alertController, animated: true, completion: { () -> Void in
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueProductDetail" {
            let vcProduct = segue.destinationViewController as! ProductDetailViewController
            let cell :ProductListCell = (sender as? ProductListCell)!
            let idxPath : NSIndexPath = self.tbViewContent.indexPathForCell(cell)!
            let model: OrderProductModel = self.orderListViewModel!.arrOrderDetail[idxPath.row]
            vcProduct.productId = Int(model.productId)
            vcProduct.navigationItem.title = model.productName
        }
    }
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductListCell") as! ProductListCell
        let model: OrderProductModel = self.orderListViewModel!.arrOrderDetail[indexPath.row]
        cell.lblTitle.text = model.productName
        cell.lblPrice.text = "￥ \(model.price)"
        cell.lblSpec.text = model.spec
        if model.imgUrl.characters.count > 0 {
            Alamofire.request(.GET, model.imgUrl).responseImage(completionHandler: { (response) in
                if let image = response.result.value {
                    cell.imgViewContent.image = image
                }
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = self.orderListViewModel?.arrOrderDetail else {
            return 0
        }
        return (list.count)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

