//
//  UIWaveSwipeController.swift
//  Refresh
//
//  Created by SCWANG on 2021/6/20.
//  Copyright © 2021 Teeyun. All rights reserved.
//

import UIKit

class UIWaveSwipeController: UIDemoHeaderController {
    
    var navShadowImage: UIImage? = nil;
    
    override func initRefreshHeader() -> UIRefreshHeader {
        return UIRefreshWaveSwipeHeader.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

        self.colorPrimary = UIColor.clear;
        self.changeTheme(UIColor.systemBlue, UIColor.white)

        if let nav = self.navigationController?.navigationBar {
            self.navShadowImage = nav.shadowImage;
            nav.shadowImage = UIImage.init();
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);

        if let nav = self.navigationController?.navigationBar {
            nav.shadowImage = self.navShadowImage;
        }
    }
}
