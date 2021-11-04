//
//  UIRefreshDeliveryController.swift
//  Refresh
//
//  Created by SCWANG on 2021/6/20.
//  Copyright © 2021 Teeyun. All rights reserved.
//

import UIKit

class UIDeliveryController: UITableViewController {

    let header = UIRefreshDeliveryHeader.init()
    
    deinit {
        NSLog("deinit-%@", self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Delivery"
        
        header.attach(self.tableView);
        header.beginRefresh();
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
    }
    
}
