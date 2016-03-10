//
//  ShoppingCartViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 2/29/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit
import CoreData

class ShoppingCartViewController: UIViewController {

    var managedContext: NSManagedObjectContext?
    var cartListArr: [ShoppingCart]?
    
    @IBOutlet weak var tbViewContent: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.navigationItem.title = "购物车"
        
        self.managedContext = appDelegate.managedObjectContext
        self.getCartList()
        // Do any additional setup after loading the view.
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
        let glManager: GlobalManager = GlobalManager.sharedInstance
        if glManager.userId == nil {
            print("please login")
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            })
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

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingCartCell") as! ShoppingCartCell

        let cart = self.cartListArr![indexPath.row] 
        cell.textLabel?.text = cart.name
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
