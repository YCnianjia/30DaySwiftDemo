//
//  SkipModel.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/17.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

class SkipModel: BaseModel {
    var title:String = ""//列表显示的title
    var controlName:String = ""//跳转的controlName
    var parameters:[String:Any]?
    
    class func addModel(title:String, controlName:String, parameters:[String:Any]?) -> SkipModel{
        let model:SkipModel = SkipModel.init()
        model.title = title
        model.controlName = controlName
        model.parameters = parameters
        return model
    }
}
