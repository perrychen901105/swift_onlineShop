//
//  AddressListViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/18/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class AddressListViewController: UIViewController {

    var addressViewModel: RequestOrder?
    
    @IBOutlet weak var tbViewContent: UITableView!
    
    /**
     点击事件，左划删除事件，新增收货地址
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addressViewModel = RequestOrder()
        self.getAllAddress()
        self.tbViewContent.rowHeight = UITableViewAutomaticDimension
        self.tbViewContent.estimatedRowHeight = 44.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllAddress() {
        if let modelOrder = self.addressViewModel {
            if let curUser = GlobalManager.sharedInstance.curUser {
                modelOrder.getAllAddress(["userId": curUser.user_id!], success: { () -> Void in
                    self.tbViewContent.reloadData()
                    }, failure: { (str) -> Void in
                        
                })
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

extension AddressListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddressListCell") as! AddressListCell
        if let modelAddress: OrderAddressModel = self.addressViewModel?.arrAddress[indexPath.row] {
            cell.lblName.text = modelAddress.receiver
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = self.addressViewModel?.arrAddress else {
            return 0
        }
        return (list.count)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
