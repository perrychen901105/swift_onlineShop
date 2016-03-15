//
//  RegisterViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/10/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var userViewModel: RequestUserCenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册"
        
        self.userViewModel = RequestUserCenter()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerAction(sender: AnyObject) {
        let params : [String: AnyObject] = ["phone":self.phoneTextField.text!, "password":self.passwordTextField.text!, "username":self.nameTextField.text!]
        self.userViewModel?.userRegister(params, success: { () -> Void in
            if let user = self.userViewModel?.userModel {
                GlobalManager.sharedInstance.curUser = user
            }
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
            }, failure: { (str) -> Void in
                
        })
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
