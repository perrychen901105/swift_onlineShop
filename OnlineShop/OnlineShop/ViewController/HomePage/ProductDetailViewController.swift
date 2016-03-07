//
//  ProductDetailViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/7/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var productId: Int?
    
    var homeViewModel: RequestHomePage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = RequestHomePage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductDetail(productId: Int) {
        weak var wself = self
        if let viewModel = self.homeViewModel {
            viewModel.getProductDetail(["productId":productId], success: { () -> Void in
                wself?.refreshUI()
                }, failure: { (str) -> Void in
                    
            })
        }
    }

    func refreshUI() {
        print(self.homeViewModel?.productDetail)
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
