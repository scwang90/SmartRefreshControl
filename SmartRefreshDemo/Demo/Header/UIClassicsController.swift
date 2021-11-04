//
//  UIClassicsController.swift
//  Refresh
//
//  Created by SCWANG on 2021/6/20.
//  Copyright © 2021 Teeyun. All rights reserved.
//

import UIKit

class UIClassicsController: UIDemoHeaderController {
    
    override func initRefreshHeader() -> UIRefreshHeader {
        return UIRefreshClassicsHeader.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
