//
//  NavigationViewController.swift
//  SmartRefreshDemo
//
//  Created by SCWANG on 2021/11/4.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController;
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
