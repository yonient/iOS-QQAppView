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
    @IBOutlet weak var tempButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    
    private var backgroundImageView: UIImageView!
    
    // 左边栏功能
    let slidebarFunction = ["激活会员","QQ钱包","个性装扮","我的收藏","我的相册","我的文件"]
    // 左边栏图标
    let slidebarIcon = ["激活会员":"vip","QQ钱包":"wallet","个性装扮":"style","我的收藏":"favorite","我的相册":"gallery","我的文件":"file"]
    
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
            let cellSlideIcon = UIImage(named: slidebarIcon["\(slidebarFunction[indexPath.row])"]!)
            let cellSlideIconSize = CGSize(width: 24, height: 20)
            UIGraphicsBeginImageContextWithOptions(cellSlideIconSize, false, 0)
            let cellSlideIconRect = CGRect(x: 0, y: 0, width: cellSlideIconSize.width, height: cellSlideIconSize.height)
            cellSlideIcon?.drawInRect(cellSlideIconRect)
            cell?.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            cell?.textLabel!.text = slidebarFunction[indexPath.row]
            cell?.textLabel?.textColor = .whiteColor()
        }
        
        if let cell = cell {
            cell.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView?.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.8)
            cell.selectionStyle = .None
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alterWindows = UIAlertController(title: slidebarFunction[indexPath.row], message: "http://www.github.com/yonient", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alterWindows.addAction(okAction)
        self.presentViewController(alterWindows, animated: true, completion: nil)
    }
}
