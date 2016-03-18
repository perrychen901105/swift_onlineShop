//
//  UserInfoViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserPhone: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的资料"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.lblUserPhone.text = "";
        self.lblUserName.text = "";
        self.btnLogin.setTitle("登录", forState: UIControlState.Normal);
        let glManager: GlobalManager = GlobalManager.sharedInstance
        if glManager.curUser?.user_id == nil {
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            })
        } else {
            self.lblUserName.text = glManager.curUser?.name
            self.lblUserPhone.text = glManager.curUser?.phone
            self.btnLogin.setTitle("退出登录", forState: UIControlState.Normal);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginAction(sender: UIButton) {
        let glManager: GlobalManager = GlobalManager.sharedInstance
        if glManager.curUser?.user_id == nil {
            // 未登录
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            })
        } else {
            // 已登录
            glManager.curUser = nil
            self.lblUserName.text = ""
            self.lblUserPhone.text = ""
            self.btnLogin.setTitle("登录", forState: UIControlState.Normal);
        }
    }
    
    
    @IBAction func myOrderAction(sender: UIButton) {
        let glManager: GlobalManager = GlobalManager.sharedInstance
        if glManager.curUser?.user_id == nil {
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            })
        } else {
            
        }
    }
    
    @IBAction func myAddressAction(sender: UIButton) {
        let glManager: GlobalManager = GlobalManager.sharedInstance
        if glManager.curUser?.user_id == nil {
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            })
        } else {
            self.performSegueWithIdentifier("showAddressList", sender: sender)
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
