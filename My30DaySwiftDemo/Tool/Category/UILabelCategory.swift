//
//  File.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/28.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

extension UILabel{
    class func createLabel(frame:CGRect, text:String?, color:UIColor?, font:CGFloat?, textAlignment:NSTextAlignment?) -> UILabel {
        let label:UILabel = UILabel.init(frame: frame)
        
        if text == nil {
            label.text = ""
        }else{
            label.text = text
        }
        
        if color == nil {
            label.textColor = UIColor.black
        }else{
            label.textColor = color
        }
        
        if font == nil {
            label.font = UIFont.systemFont(ofSize: 16)
        }else{
            label.font = UIFont.systemFont(ofSize: font!)
        }
        
        if textAlignment == nil {
            label.textAlignment = NSTextAlignment.left
        }else{
            label.textAlignment = textAlignment!
        }
        
        return label
    }
}
