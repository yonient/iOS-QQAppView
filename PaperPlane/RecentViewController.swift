//
//  RecentViewController.swift
//  PaperPlane
//
//  Created by Kenneth Zhang on 16/4/12.
//  Copyright © 2016年 me.yzo. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController {
    
    private var recentTableView: UITableView!
    private var telephoneTableView: UITableView!
    private var searchController: UISearchController!
    private var leftSlideMenuController: LeftSlideMenuController!
    var test = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: nil)
        rightAddButton.tintColor = .whiteColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 183/255, blue: 242/255, alpha: 1)
        navigationItem.rightBarButtonItem = rightAddButton
        
        let leftImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftImageButton.setBackgroundImage(UIImage(named: "testLogo"), forState: .Normal)
        leftImageButton.layer.cornerRadius = 20
        leftImageButton.layer.masksToBounds = true
        let leftImageBarButton = UIBarButtonItem(customView: leftImageButton)
        navigationItem.leftBarButtonItem = leftImageBarButton
        
        let segmentFrame: CGRect = CGRect(origin: UIScreen.mainScreen().bounds.origin, size: CGSize(width: UIScreen.mainScreen().bounds.width - 250, height: 30))
        let navigationSegment = UISegmentedControl.init(items: ["消息","电话"])
        navigationSegment.tintColor = .whiteColor()
        navigationSegment.setTitleTextAttributes([NSFontAttributeName:UIFont(name: "Helvetica-Bold", size: 15)!], forState: .Normal)
        navigationSegment.selectedSegmentIndex = 0
        navigationSegment.frame = segmentFrame
        navigationSegment.addTarget(self, action: #selector(RecentViewController.switchSegment(_:)), forControlEvents: .ValueChanged)
        navigationItem.titleView = navigationSegment
        
        
//        let testLogoView: UIImageView = UIImageView(frame: CGRect(origin: view.bounds.origin, size: view.bounds.size))
//        testLogoView.image = UIImage(named: "testLogo")
//        testLogoView.layer.cornerRadius = testLogoView.frame.size.width/2
//        testLogoView.layer.masksToBounds = true
//        view.addSubview(testLogoView)
        
        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.tintColor = .grayColor()
        
        addRecentTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRecentTableView() {
        recentTableView = UITableView(frame: view.bounds)
        recentTableView.dataSource = self
        recentTableView.delegate = self
        
        if recentTableView.respondsToSelector(Selector("setSeparatorInset:")) {
            recentTableView.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
        if recentTableView.respondsToSelector(Selector("setLayoutMargins:")) {
            recentTableView.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
        
        recentTableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true   //解决 TableView 向上偏移 64 像素（下面透明）的问题
        
        view.addSubview(recentTableView)
    }
    
    func switchSegment(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            addRecentTableView()
            break;
        case 1:
            recentTableView.removeFromSuperview()
            telephoneTableView = UITableView(frame: view.bounds)
            
            break;
        default:
            break;
        }
    }
    
}

extension RecentViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "测试1"
        case 1:
            return "测试2"
        default:
            break
        }
        return nil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            
            let sampleImage = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
            sampleImage.image = UIImage(named: "testLogo")
            sampleImage.layer.cornerRadius = 20
            sampleImage.layer.masksToBounds = true
            cell?.contentView.addSubview(sampleImage)
            
            let sampleLabel = UILabel(frame: CGRect(x: 60, y: 12, width: view.bounds.size.width - 60, height: 15))
            sampleLabel.font = UIFont(name: "Helvetica", size: 15)
            cell?.contentView.addSubview(sampleLabel)
            
            let contentLabel = UILabel(frame: CGRect(x: 60, y: 30, width: view.bounds.size.width - 60, height: 15))
            contentLabel.textColor = UIColor.grayColor()
            contentLabel.font = UIFont(name: "Helvetica", size: 10)
            cell?.contentView.addSubview(contentLabel)
            
            switch indexPath.row {
            case 0:
                sampleLabel.text = "丛林峰工作室"
                contentLabel.text = "蟹蟹李妈带我们坐小车车"
                break;
            case 1:
                sampleLabel.text = "飞向丛林"
                contentLabel.text = "晓涌哥最帅"
                break;
            default:
                break;
            }
        }
        
        if let cell = cell {
            cell.selectionStyle = .None
            cell.backgroundColor = .clearColor()
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector(Selector("setSeparatorInset:")) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
        if cell.respondsToSelector(Selector("setLayoutMargins:")) {
            cell.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
    }
}

extension RecentViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
}