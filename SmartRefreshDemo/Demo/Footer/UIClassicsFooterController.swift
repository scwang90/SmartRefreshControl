//
//  UIClassicsFooterController.swift
//  Refresh
//
//  Created by SCWANG on 2021/7/5.
//  Copyright © 2021 Teeyun. All rights reserved.
//

import UIKit

class UIClassicsFooterController: UIDemoFooterController {
    
    override func initRefreshFooter() -> UIRefreshFooter {
        return UIRefreshClassicsFooter.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
