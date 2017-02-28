//
//  SkipViewModel.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/27.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

class SkipViewModel: BaseModel {
    
    class func gotoVC(skipModel:SkipModel, formVC:BaseViewController) -> Void {
        
        //获取controller的属性列表
        let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        let classStringName = "\(appName).\(skipModel.controlName)"
        let anyClass:AnyClass? = NSClassFromString(classStringName)
        var vcDict:[String:String] = [:];
        if anyClass != nil {
            vcDict =  DictModelManager.sharedManager.fullModelInfo(cls: anyClass!)
        }

        let toVC = skipModel.swiftClassFromString(className: skipModel.controlName)
        if skipModel.parameters != nil && (skipModel.parameters?.count)! > 0 {
            for (key , value) in skipModel.parameters! {
                if vcDict[key] != nil {
                    toVC?.setValue(value, forKey: key)
                }
            }
        }
        
        //设置下一controller的title
        toVC?.title = skipModel.title
        
        formVC.navigationController?.pushViewController(toVC!, animated: true)
    }
}
