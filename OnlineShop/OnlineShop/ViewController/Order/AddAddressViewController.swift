//
//  AddAddressViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/22/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {

    @IBOutlet weak var tfDeliveryName: UITextField!
    
    @IBOutlet weak var tfDeliveryPhone: UITextField!
    
    @IBOutlet weak var tvDeliveryAddress: UITextView!
    
    var addressViewModel: RequestOrder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addressViewModel = RequestOrder()
        self.navigationItem.title = "添加地址"
        let naviAdd: UIBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: Selector("actionSave"))
        self.navigationItem.rightBarButtonItem = naviAdd
        self.tvDeliveryAddress.layer.borderColor = UIColor.grayColor().CGColor
        self.tvDeliveryAddress.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
    }

    func actionSave() {
        if let curUser = GlobalManager.sharedInstance.curUser {
            let paras: [String: AnyObject] = ["receiver": self.tfDeliveryName.text!, "phone": self.tfDeliveryPhone.text!, "address": self.tvDeliveryAddress.text, "uid": curUser.user_id!]
            self.addressViewModel?.addAddress(paras, success: { () -> Void in
                self.navigationController?.popViewControllerAnimated(true)
                }, failure: { (str) -> Void in
                    
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
