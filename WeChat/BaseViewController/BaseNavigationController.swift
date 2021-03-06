//
//  BaseNavigationController.swift
//  WeChat
//
//  Created by panzhijun on 2019/5/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barStyle = UIBarStyle.default
        
        self.navigationBar.tintColor = UIColor.ThemeDefaultColor()
        
        let dict : NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.ThemeDefaultColor(),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true

        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // 如果重写了naigation需要重写一下方法 才可用修改状态栏颜色
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
