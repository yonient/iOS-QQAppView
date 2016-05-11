//
//  FirstViewController.swift
//  PaperPlane
//
//  Created by Kenneth Zhang on 16/4/11.
//  Copyright © 2016年 me.yzo. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 183/255, blue: 242/255, alpha: 1)
        
        let rightAddButton = UIBarButtonItem(title: "添加", style: .Plain, target: self, action: nil)
        rightAddButton.tintColor = .whiteColor()
        navigationItem.rightBarButtonItem = rightAddButton
        
        let leftImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftImageButton.setBackgroundImage(UIImage(named: "testLogo"), forState: .Normal)
        leftImageButton.layer.cornerRadius = 20
        leftImageButton.layer.masksToBounds = true
        let leftImageBarButton = UIBarButtonItem(customView: leftImageButton)
        navigationItem.leftBarButtonItem = leftImageBarButton
        
        let customTitleFrame: CGRect = CGRect(origin: UIScreen.mainScreen().bounds.origin, size: CGSize(width: UIScreen.mainScreen().bounds.width - 250, height: 30))
        let titleView: UIView = UIView(frame: customTitleFrame)
        titleView.backgroundColor = UIColor.clearColor()
        navigationItem.titleView = titleView
        
        let navigationTitle: UILabel = UILabel(frame: customTitleFrame)
        navigationTitle.text = "联系人"
        navigationTitle.textAlignment = .Center
        navigationTitle.textColor = UIColor.whiteColor()
        titleView.addSubview(navigationTitle)
        
        self.view.backgroundColor = .whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

