//
//  TabBarController.swift
//  PaperPlane
//
//  Created by Kenneth Zhang on 16/4/15.
//  Copyright © 2016年 me.yzo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recentVC = RecentViewController()
        let contactVC = ContactViewController()
        let spaceVC = SpaceViewController()
        
        let recentNav = UINavigationController(rootViewController: recentVC)
        let contactNav = UINavigationController(rootViewController: contactVC)
        let spaceNav = UINavigationController(rootViewController: spaceVC)
        
        let controllers = [recentNav, contactNav, spaceNav]
        self.viewControllers = controllers
        
        recentNav.tabBarItem = UITabBarItem(title: "消息", image: UIImage(named: "message"), tag: 1)
        contactNav.tabBarItem = UITabBarItem(title: "联系人", image: UIImage(named: "contactIcon"), tag: 2)
        spaceNav.tabBarItem = UITabBarItem(title: "动态", image: UIImage(named: "star"), tag: 2)
        
        
    }
}