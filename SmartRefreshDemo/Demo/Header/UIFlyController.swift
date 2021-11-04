//
//  UIFlyController.swift
//  Refresh
//
//  Created by SCWANG on 2021/6/20.
//  Copyright © 2021 Teeyun. All rights reserved.
//

import UIKit

class UIFlyController: UIDemoHeaderController {
    
    var navShadowImage: UIImage? = nil;
    
    override func initRefreshHeader() -> UIRefreshHeader {
        return UIRefreshFlyHeader.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

        let color = UIColor.init(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        
        self.changeTheme(color, UIColor.white)

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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}
