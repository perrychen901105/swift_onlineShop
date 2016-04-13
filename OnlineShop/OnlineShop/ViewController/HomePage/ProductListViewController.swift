//
//  ProductListViewController.swift
//  OnlineShop
//
//  Created by PerryChen on 3/3/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductListViewController: UIViewController {

    var categoryId: Int?
    
    var homeViewModel: RequestHomePage?
    
    @IBOutlet weak var tbViewContent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = RequestHomePage()
        
        if let cateId = self.categoryId {
            self.getProductsByCategory(cateId)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductsByCategory(cateId: Int) {
        weak var wself = self
        if let viewModel = self.homeViewModel {
            viewModel.getProductsList(["categoryId": cateId], success: { () -> Void in
                wself?.refreshUI()
                }, failure: { (str) -> Void in
                    
            })
        }
    }

    func refreshUI() {
        self.tbViewContent.reloadData()
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
            let model: ProductModel = self.homeViewModel!.products![idxPath.row]
            vcProduct.productId = Int(model.productId!)
            vcProduct.navigationItem.title = model.name
        }
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductListCell") as! ProductListCell
        let model: ProductModel = self.homeViewModel!.products![indexPath.row]
        cell.lblTitle.text = model.name
        cell.lblPrice.text = String("￥ \(model.original_price)")
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
        guard let list = self.homeViewModel?.products else {
            return 0
        }
        return (list.count)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
