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
    
    @IBOutlet weak var tbViewContent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = RequestHomePage()
        self.tbViewContent.estimatedRowHeight = 24.0
        self.tbViewContent.rowHeight = UITableViewAutomaticDimension
        
        self.getAllCategory()
        
        self.navigationItem.title = "商品类别"
    }

    func getAllCategory() {
        weak var wself = self
        if let viewModel = self.homeViewModel {
            viewModel.getCategoryList(["":""], success: { () -> Void in
                wself!.refreshUI()
                }, failure: { (str) -> Void in
                    
            })
        }
    }
    
    func refreshUI() {
        self.tbViewContent.reloadData()
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

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryListCell") as! CategoryListCell
        let model: CategoryModel = self.homeViewModel!.categories![indexPath.row]
        cell.lblContent.text = model.name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = self.homeViewModel?.categories else {
            return 0
        }
        return (list.count)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
