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
        
        let customTitleFrame: CGRect = CGRect(origin: UIScreen.mainScreen().bounds.origin, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 30))
        let titleView: UIView = UIView(frame: customTitleFrame)
        titleView.backgroundColor = UIColor.clearColor()
        navigationItem.titleView = titleView
        
        let navigationTitle: UILabel = UILabel(frame: customTitleFrame)
        navigationTitle.text = "联系人"
        navigationTitle.textAlignment = .Center
        navigationTitle.textColor = UIColor.whiteColor()
        
        titleView.addSubview(navigationTitle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

