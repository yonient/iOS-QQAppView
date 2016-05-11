//
//  ViewController.swift
//  PaperPlane
//
//  Created by Kenneth Zhang on 16/4/15.
//  Copyright © 2016年 me.yzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CloseSlideMenuDelegate {
    private var homeTabBarController: TabBarController!
    private var slideMenu: LeftSlideMenuController!
    private var panGesture: UIPanGestureRecognizer!
    private var tapGesture: UITapGestureRecognizer!
    private var tapToShowSlideMenuGesture: UITapGestureRecognizer!
    private var navigationBarHeight: CGFloat!
    private var tabBarHeight: CGFloat!
    private var availableArea: CGMutablePathRef!
    
    let distancePercent: CGFloat = 0.8
    
    override func viewDidLoad() {
        homeTabBarController = TabBarController()
        slideMenu = LeftSlideMenuController()
        
        let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
        navigationBarHeight = selectedView?.visibleViewController?.navigationController?.navigationBar.bounds.size.height
        tabBarHeight = selectedView?.visibleViewController?.tabBarController?.tabBar.bounds.size.height
        
        view.addSubview(slideMenu.view)
        view.addSubview(homeTabBarController.view)
        
        createAvailableArea(UIScreen.mainScreen().bounds.size.width / 6)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(_:)))
        self.homeTabBarController.view.addGestureRecognizer(panGesture)
        
        slideMenu.delegate = selectedView?.visibleViewController as? SlideMenuDelegate
        slideMenu.closeDelegate = self
    }
    
    func createAvailableArea(x: CGFloat) {
        availableArea = CGPathCreateMutable()
        CGPathMoveToPoint(availableArea, nil, x - UIScreen.mainScreen().bounds.size.width / 6, navigationBarHeight ?? 0)
        CGPathAddLineToPoint(availableArea, nil, x + UIScreen.mainScreen().bounds.size.width / 6, navigationBarHeight ?? 0)
        CGPathAddLineToPoint(availableArea, nil, x + UIScreen.mainScreen().bounds.size.width / 6, UIScreen.mainScreen().bounds.size.height - (tabBarHeight ?? 0) )
        CGPathAddLineToPoint(availableArea, nil, x - UIScreen.mainScreen().bounds.size.width / 6, UIScreen.mainScreen().bounds.size.height - (tabBarHeight ?? 0))
        CGPathAddLineToPoint(availableArea, nil, x - UIScreen.mainScreen().bounds.size.width / 6, navigationBarHeight ?? 0)
        CGPathCloseSubpath(availableArea)
    }
    
    func pan(recongnizer: UIPanGestureRecognizer) {
        let currentPressPoint = panGesture.locationInView(self.homeTabBarController.view)
        
        if CGPathContainsPoint(availableArea, nil, currentPressPoint, false) {
            let x = recongnizer.translationInView(self.homeTabBarController.view).x
            let velocityx = 0.2 * recongnizer.velocityInView(self.homeTabBarController.view).x
            print(x)
            print(velocityx)
            createAvailableArea(currentPressPoint.x)
            if recongnizer.state == .Changed {
                if recongnizer.view!.frame.origin.x < 0.75 * UIScreen.mainScreen().bounds.size.width {
                    recongnizer.view!.center.x += x
                    self.slideMenu.view.center.x += x * 3 / 8
                    recongnizer.setTranslation(CGPoint(x: 0,y: 0), inView: self.view)
                    
                    // 头像透明
                    let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
                    let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
                    
                    avatarBarButton?.customView?.layer.opacity -= 0.009
                }
            }
            if recongnizer.state == .Ended {
                if recongnizer.view!.center.x >= UIScreen.mainScreen().bounds.size.width * (5 / 6) || velocityx > 80 {
                    print("yes")
                    presentSlideMenu()
                } else {
                    print("no")
                    dismissSlideMenu()
                }
                return
            }
        }
    }
    
    // 展示左视图
    func presentSlideMenu() {
        // 给首页 加入 点击自动关闭侧滑菜单功能
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissSlideMenu(_:)))
        self.homeTabBarController.view.addGestureRecognizer(tapGesture)
        
        print("该出现了")
        // 计算距离，执行菜单自动滑动动画
        let mainViewDistance = UIScreen.mainScreen().bounds.size.width * 0.8
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.createAvailableArea(UIScreen.mainScreen().bounds.size.width * 0.96)
            self.homeTabBarController.view.frame.origin.x = mainViewDistance
            self.slideMenu.view.frame.origin.x = 0
            
            // 头像透明
            let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
            let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
            
            avatarBarButton?.customView?.layer.opacity = 0
            }, completion: nil)
        
    }
    
    func dismissSlideMenu(recongnizer: UITapGestureRecognizer) {
        let currentPressPoint = panGesture.locationInView(self.view)
        if CGPathContainsPoint(availableArea, nil, currentPressPoint, false) {
            print("该消失了")
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.createAvailableArea(UIScreen.mainScreen().bounds.size.width / 6)
                self.homeTabBarController.view.frame.origin.x = 0
                self.slideMenu.view.frame.origin.x = -UIScreen.mainScreen().bounds.size.width*0.3
                
                // 头像恢复
                let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
                let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
                
                avatarBarButton?.customView?.layer.opacity = 1
                }, completion: nil)
        }
        self.homeTabBarController.view.removeGestureRecognizer(recongnizer)
    }
    
    func dismissSlideMenu() {
        print("该消失了")
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.createAvailableArea(UIScreen.mainScreen().bounds.size.width / 6)
            self.homeTabBarController.view.frame.origin.x = 0
            self.slideMenu.view.frame.origin.x = -UIScreen.mainScreen().bounds.size.width*0.3
                
            // 头像恢复
            let selectedView = self.homeTabBarController.selectedViewController as? UINavigationController
            let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
                
            avatarBarButton?.customView?.layer.opacity = 1
            }, completion: nil)
    }
    
    func closeSlideMenu() {
        self.homeTabBarController.view.removeGestureRecognizer(tapGesture)
        self.homeTabBarController.view.removeGestureRecognizer(panGesture)
        dismissSlideMenu()
    }
    
    func backFromNavigation() {
        self.homeTabBarController.view.addGestureRecognizer(panGesture)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
