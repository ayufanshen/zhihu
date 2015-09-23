//
//  HomeCell.swift
//  zhihu
//
//  Created by fanshen on 15/9/16.
//  Copyright (c) 2015年 fanshen. All rights reserved.
//

import UIKit


class HomeCell: UITableViewCell {
    
    var lable:UILabel!
    var imgView:UIImageView!
    
    var dataDict:NSDictionary!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView = UIImageView(frame: CGRectMake(width - 120, 10, 100 , 80))
        imgView.backgroundColor = UIColor.redColor()
        self.addSubview(imgView)
        
        
        lable = UILabel(frame: CGRectMake(20, 10, width - 160 , 80))
//        lable.backgroundColor = UIColor.blueColor()
        lable.textAlignment = NSTextAlignment.Left
        lable.numberOfLines = 0
        self.contentView.addSubview(lable)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        lable.text = dataDict.objectForKey("title") as? String
        
    }
}
