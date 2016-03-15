//
//  LoginViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/10/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    
    var userViewModel: RequestUserCenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userViewModel = RequestUserCenter()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionLogin(sender: UIButton) {
        let params : [String: AnyObject] = ["phone":self.tfPhone.text!, "password":self.tfPwd.text!]
        self.userViewModel?.loginAction(params, success: { () -> Void in
            if let user = self.userViewModel?.userModel {
                GlobalManager.sharedInstance.curUser = user
            }
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
            }, failure: { (str) -> Void in
                
        })
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
