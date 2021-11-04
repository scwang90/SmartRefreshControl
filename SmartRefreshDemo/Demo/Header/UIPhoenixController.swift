//
//  UIPhoenixController.swift
//  Refresh
//
//  Created by SCWANG on 2021/6/20.
//  Copyright © 2021 Teeyun. All rights reserved.
//

import UIKit

class UIPhoenixController: UIDemoHeaderController {
    
    override func initRefreshHeader() -> UIRefreshHeader {
        return UIRefreshPhoenixHeader.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
