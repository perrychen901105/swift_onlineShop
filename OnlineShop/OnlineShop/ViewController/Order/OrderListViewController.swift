//
//  OrderListViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 2/26/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController {

    var orderListViewModel: RequestOrder?
    
    @IBOutlet weak var viewNoOrder: UIView!
    
    @IBOutlet weak var tbViewContent: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "订单列表"
        self.orderListViewModel = RequestOrder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.orderListViewModel?.getOrderList([:], success: {
            self.viewNoOrder.hidden = true
            if self.orderListViewModel?.arrOrderList.count == 0 {
                self.viewNoOrder.hidden = false
            }
            
            self.tbViewContent.reloadData()
            }, failure: { (str) in
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueOrderDetail" {
            let vcDetail: OrderDetailViewController = segue.destinationViewController as! OrderDetailViewController
            let idxPath: NSIndexPath = sender as! NSIndexPath
            let model = self.orderListViewModel?.arrOrderList[idxPath.row]
            vcDetail.orderId = model?.orderId
        }
    }
    
}

extension OrderListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = self.orderListViewModel?.arrOrderList else {
            return 0
        }
        return (list.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderListCell") as! OrderListCell
        if let modelOrder: OrderListModel = self.orderListViewModel?.arrOrderList[indexPath.row] {
            cell.lblOrderName.text = "订单编号: \(modelOrder.orderId!)"
            var date = NSDate(timeIntervalSince1970: NSTimeInterval(modelOrder.orderTime)!)
            var shortDate: String {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                return dateFormatter.stringFromDate(date)
            }
            cell.lblOrderTime.text = shortDate
            cell.lblOrderPrice.text = "￥ \(modelOrder.totalPrice!)"
            cell.lblOrderAddress.text = modelOrder.address!
        }
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("segueOrderDetail", sender: indexPath)
    }
}
