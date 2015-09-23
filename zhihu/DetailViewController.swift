//
//  DetailViewController.swift
//  zhihu
//
//  Created by fanshen on 15/9/18.
//  Copyright (c) 2015年 fanshen. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class DetailViewController: UIViewController,UIScrollViewDelegate {
    
    var webView = UIWebView()
    var id:Int!
    var url = "https://news-at.zhihu.com/api/3/news/" as String
    var topImgView = UIImageView()
    var imgUrl:NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoUrl = NSURL(string: "\(url)\(id)")
        
        
        self.webView = UIWebView(frame: CGRectMake(0, 0, width, height))
        self.view.addSubview(self.webView)
        
        self.topImgView = UIImageView(frame: CGRectMake(0, 0, width, 210))
//        self.topImgView.backgroundColor = UIColor.grayColor()
//        self.topImgView.image?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode:UIImageResizingMode.Stretch)
        self.webView.scrollView.addSubview(self.topImgView)
        
        
        
        Alamofire.request(.GET, infoUrl!).response { (request, response, data, error) -> Void in
            
            let json = JSON(data: data!)
 
            var body = json["body"].stringValue
            let cssUrl = json["css"][0].stringValue

            body = "<link href='\(cssUrl)' rel='stylesheet' type='text/css' />\(body)"
            self.webView.loadHTMLString(body, baseURL:nil )
            
            
            let imgStr = json["image"].stringValue
            self.topImgView.sd_setImageWithURL(NSURL(string: imgStr))
                    }
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }


    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    
}






