//
//  ViewController.swift
//  PaperPlane
//
//  Created by Kenneth Zhang on 16/4/15.
//  Copyright © 2016年 me.yzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var homeTabBarController: TabBarController!
    private var slideMenu: LeftSlideMenuController!
    private var panGesture: UIPanGestureRecognizer!
    private var tapGesture: UITapGestureRecognizer!
    private var tapToShowSlideMenuGesture: UITapGestureRecognizer!
    private var availabelArea: UIView!
    
    let distancePercent: CGFloat = 0.8
    
    override func viewDidLoad() {
        homeTabBarController = TabBarController()
        slideMenu = LeftSlideMenuController()
        
        let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
        let navigationBarHeight = selectedView?.visibleViewController?.navigationController?.navigationBar.bounds.size.height
        let tabBarHeight = selectedView?.visibleViewController?.tabBarController?.tabBar.bounds.size.height
        
        availabelArea = UIView(frame: CGRect(x: 0, y: navigationBarHeight ?? 0, width: UIScreen.mainScreen().bounds.size.width / 3, height: UIScreen.mainScreen().bounds.size.height - (navigationBarHeight ?? 0) - (tabBarHeight ?? 0) ))
        
        view.addSubview(slideMenu.view)
        view.addSubview(homeTabBarController.view)
        view.addSubview(availabelArea)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(_:)))
        availabelArea.addGestureRecognizer(panGesture)
    }
    
    func pan(recongnizer: UIPanGestureRecognizer) {
        let x = recongnizer.translationInView(self.view).x
        print(x)
        let distance = x / (UIScreen.mainScreen().bounds.size.width * distancePercent)
        
        if recongnizer.state == UIGestureRecognizerState.Ended {
            
            if x > UIScreen.mainScreen().bounds.size.width * (distancePercent / 3) {
                presentSlideMenu()
            } else {
//                showHome()
            }
            
            return
        }
    }
    
    // 展示左视图
    func presentSlideMenu() {
        // 给首页 加入 点击自动关闭侧滑菜单功能
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissSlideMenu(_:)))
        availabelArea.addGestureRecognizer(tapGesture)
        
        print("该出现了")
        // 计算距离，执行菜单自动滑动动画
        let mainViewDistance = UIScreen.mainScreen().bounds.size.width * 0.8
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.availabelArea.frame.origin.x = mainViewDistance
            self.homeTabBarController.view.frame.origin.x = mainViewDistance
            self.slideMenu.view.frame.origin.x = 0
            
            // 头像透明
            let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
            let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
            
            print(avatarBarButton?.customView)
            
            avatarBarButton?.customView?.layer.opacity = 0
            }, completion: nil)
        
    }
    
    func dismissSlideMenu(recongnizer: UITapGestureRecognizer) {
        print("该消失了")
        let slideMenuDistance = UIScreen.mainScreen().bounds.size.width * 0.2
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.availabelArea.frame.origin.x = 0
            self.homeTabBarController.view.frame.origin.x = 0
            self.slideMenu.view.frame.origin.x = -slideMenuDistance
            
            // 头像恢复
            let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
            let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
            
            avatarBarButton?.customView?.layer.opacity = 1
            }, completion: nil)
    }
}
