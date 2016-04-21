//
//  LeftSlideMenuController.swift
//  PaperPlane
//
//  Created by Kenneth Zhang on 16/4/14.
//  Copyright © 2016年 me.yzo. All rights reserved.
//

import UIKit

class LeftSlideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var functionTableView: UITableView!
    private var backgroundImageView: UIImageView!
    
    let slidebarFunction = ["激活会员","QQ钱包","个性装扮","我的收藏","我的相册","我的文件"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        avatarImageView.layer.cornerRadius = 22.5
        avatarImageView.layer.masksToBounds = true
        
        functionTableView.delegate = self
        functionTableView.dataSource = self
        
        functionTableView.backgroundColor = .clearColor()
        
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width*0.8, height: UIScreen.mainScreen().bounds.size.height))
        backgroundImageView.image = UIImage(named: "slideBackground")
        backgroundImageView.contentMode = .ScaleToFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        view.frame = CGRect(x: -UIScreen.mainScreen().bounds.size.width*0.3, y: 0, width: UIScreen.mainScreen().bounds.size.width*0.8, height: UIScreen.mainScreen().bounds.size.height)
        view.layoutIfNeeded()
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slidebarFunction.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "leftViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            cell?.textLabel!.text = slidebarFunction[indexPath.row]
            cell?.textLabel?.textColor = .whiteColor()
        }
        
        if let cell = cell {
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }
        
        return UITableViewCell()
    }
}
