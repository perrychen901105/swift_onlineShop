//
//  HomePageViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 2/26/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    var homeViewModel: RequestHomePage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = RequestHomePage()
        guard let hvm = self.homeViewModel else {
            return
        }
        hvm.getProductsList(100, success: { () -> Void in
            print("the home model is \(self.homeViewModel)")
            }) { (str) -> Void in
                print(str)
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
