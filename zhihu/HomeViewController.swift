//
//  HomeViewController.swift
//  zhihu
//
//  Created by fanshen on 15/9/8.
//  Copyright (c) 2015年 fanshen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var dataArr:NSArray = NSArray()
    var dataDict = NSDictionary()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "今日热闻"
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: height), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.registerClass(HomeCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.hidden = true
        
        Alamofire.request(.GET, HomeUrlStr).response { (request, response, data_, error) -> Void in
            
//               var i = data_?.classForCoder
            let json = JSON(data:data_!)
            let arr  = json["stories"].arrayObject
            self.dataArr = (arr as? NSArray)!

            tableView.reloadData()
            tableView.hidden = false
        }

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        if((indexPath.section == 0) && (indexPath.row == 0)){
            return 200
        }else{
            return 100
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:HomeCell
        cell = tableView.dequeueReusableCellWithIdentifier("cell") as! HomeCell
        cell.dataDict = self.dataArr.objectAtIndex(indexPath.row) as! NSDictionary
        
        let imgUrlArr = cell.dataDict["images"] as! NSArray
        let imgUrl = imgUrlArr.objectAtIndex(0) as! NSString
        cell.imgView.sd_setImageWithURL(NSURL(string: imgUrl as String), placeholderImage: UIImage(named: ""))
//        print("\(cell.dataDict)")
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let detailVC = DetailViewController()
        let dict = self.dataArr.objectAtIndex(indexPath.row) as! NSDictionary
        detailVC.id = dict.objectForKey("id") as? Int
//        detailVC.imgUrl = [dict["images"] as! NSArray][0] as NSURL
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
