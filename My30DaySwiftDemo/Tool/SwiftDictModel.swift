//
//  SwiftDictModel.swift
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6


import Foundation

@objc public protocol DictModelProtocol {
    static func customClassMapping() -> [String: String]?
}

///  字典转模型管理器
public class DictModelManager {
    
    private static let instance = DictModelManager()
    /// 全局统一访问入口
    public class var sharedManager: DictModelManager {
        return instance
    }
    
    ///  字典转模型
    ///  - parameter dict: 数据字典
    ///  - parameter cls:  模型类
    ///
    ///  - returns: 模型对象
    public func objectWithDictionary(dict: NSDictionary, cls: AnyClass) -> AnyObject? {
        
        // 动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
        // 模型信息
        let infoDict = fullModelInfo(cls: cls)
        
        let obj: AnyObject = (cls as! NSObject.Type).init()
        
        autoreleasepool {
            // 3. 遍历模型字典
            for (k, v) in infoDict {
                if k == "targetType"{
                    print("sdsfsfsa")
                }
                if k == "desc" {//特殊处理
                    let newValue = dict["description"] as? String
                    obj.setValue(newValue, forKey: "desc")
                }
                if let value: AnyObject = dict[k] as AnyObject? {
                    
                    if v.isEmpty {
                        if !(value === NSNull()) {
                            
                            obj.setValue(value, forKey: k)
                        }
                        
                    } else {
                        let type = "\(value.classForCoder)"
                        
                        if type == "NSDictionary" {
                            
                            if let subObj: AnyObject = objectWithDictionary(dict: value as! NSDictionary, cls: NSClassFromString(ns + "." + v)!) {
                                obj.setValue(subObj, forKey: k)
                            }
                            
                        } else if type == "NSArray" {
                            
                            if let subObj: AnyObject = objectsWithArray(array: value as! NSArray, cls: NSClassFromString(ns + "." + v)!) {
                                obj.setValue(subObj, forKey: k)
                            }
                        }
                    }
                }
            }
        }
        
        return obj
    }
    
    
    ///  创建自定义对象数组
    ///
    ///  - parameter NSArray: 字典数组
    ///  - parameter cls:     模型类
    ///
    ///  - returns: 模型数组
    public func objectsWithArray(array: NSArray, cls: AnyClass) -> NSArray? {
        
        var list = [AnyObject]()
        
        autoreleasepool { () -> () in
            for value in array {
                let type = "\((value as AnyObject).classForCoder)"
                
                if type == "NSDictionary" {
                    if let subObj: AnyObject = objectWithDictionary(dict: value as! NSDictionary, cls: cls) {
                        list.append(subObj)
                    }
                } else if type == "NSArray" {
                    if let subObj: AnyObject = objectsWithArray(array: value as! NSArray, cls: cls) {
                        list.append(subObj)
                    }
                }
            }
        }
        
        if list.count > 0 {
            return list as NSArray?
        } else {
            return nil
        }
    }
    
    ///  创建自定义对象数组
    ///
    ///  - parameter NSArray: 字典下包含字典数组
    ///  - parameter cls:     模型类
    ///  - parameter key:     数组对应键值
    ///  - returns: 模型数组
    public func objectsWithDictionary(obj: AnyObject, key: NSString!, cls: AnyClass) -> NSArray? {
        
        let array:NSArray? = obj.objectFor(key) as? NSArray
        if array == nil {
            return nil
        }
        
        var list = [AnyObject]()
        autoreleasepool { () -> () in
            for value in array! {
                let type = "\((value as AnyObject).classForCoder)"
                
                if type == "Optional(NSDictionary)" {
                    if let subObj: AnyObject = objectWithDictionary(dict: value as! NSDictionary, cls: cls) {
                        list.append(subObj)
                    }
                } else if type == "Optional(NSArray)" {
                    if let subObj: AnyObject = objectsWithArray(array: value as! NSArray, cls: cls) {
                        list.append(subObj)
                    }
                }
            }
        }
        
        if list.count > 0 {
            return list as NSArray?
        } else {
            return nil
        }
    }
    
    ///  模型转字典
    ///
    ///  - parameter obj: 模型对象
    ///
    ///  - returns: 字典信息
    public func objectDictionary(obj: AnyObject) -> [String: AnyObject]? {
        // 1. 取出对象模型字典
        let infoDict = fullModelInfo(cls: obj.classForCoder)
        
        var result = [String: AnyObject]()
        // 2. 遍历字典
        for (k, v) in infoDict {
//            var value: AnyObject? = obj.valueForKey(k)
            var value: AnyObject? = obj.value(forKey: k) as AnyObject
            if value == nil {
                value = NSNull()
            }
            
            if v.isEmpty || value === NSNull() {
                result[k] = value
            } else {
                let type = "\(value!.classForCoder)"
                
                var subValue: AnyObject?
                if type == "NSArray" {
                    subValue = objectArray(array: value! as! [AnyObject]) as AnyObject?
                } else {
                    subValue = objectDictionary(obj: value!) as AnyObject?
                }
                if subValue == nil {
                    subValue = NSNull()
                }
                result[k] = subValue
            }
        }
        
        if result.count > 0 {
            return result
        } else {
            return nil
        }
    }
    
    ///  模型数组转字典数组
    ///
    ///  - parameter array: 模型数组
    ///
    ///  - returns: 字典数组
    public func objectArray(array: [AnyObject]) -> [AnyObject]? {
        
        var result = [AnyObject]()
        
        for value in array {
            let type = "\(value.classForCoder)"
            
            var subValue: AnyObject?
            if type == "NSArray" {
                subValue = objectArray(array: value as! [AnyObject]) as AnyObject?
            } else {
                subValue = objectDictionary(obj: value) as AnyObject?
            }
            if subValue != nil {
                result.append(subValue!)
            }
        }
        
        if result.count > 0 {
            return result
        } else {
            return nil
        }
    }
    
    // MARK: - 私有函数
    ///  加载完整类信息
    ///
    ///  - parameter cls: 模型类
    ///
    ///  - returns: 模型类完整信息
    func fullModelInfo(cls: AnyClass) -> [String: String] {
        
        // 检测缓冲池
        if let cache = modelCache["\(cls)"] {
            return cache
        }
        
        var currentCls: AnyClass = cls
        
        var infoDict = [String: String]()
        while let parent: AnyClass = currentCls.superclass() {
            infoDict.merge(dict: modelInfo(cls: currentCls))
            currentCls = parent
        }
        
        // 写入缓冲池
        modelCache["\(cls)"] = infoDict
        
        return infoDict
    }
    
    ///  加载类信息
    ///
    ///  - parameter cls: 模型类
    ///
    ///  - returns: 模型类信息
    func modelInfo(cls: AnyClass) -> [String: String] {
        // 检测缓冲池
        if let cache = modelCache["\(cls)"] {
            return cache
        }
        
        // 拷贝属性列表
        var count: UInt32 = 0
        let properties = class_copyPropertyList(cls, &count)
        
        // 检查类是否实现了协议
        var mappingDict: [String: String]?
//        if cls.respondsToSelector("customClassMapping") {
//        if cls.responds(to: #selector(cls.customClassMapping)) {
//            mappingDict = cls.customClassMapping()
//        }
        
        var infoDict = [String: String]()
        for i in 0..<count {
            let property = properties?[Int(i)]
            
            // 属性名称
            let cname = property_getName(property)
//            let name = String.fromCString(cname!)!
            let name = String(cString:cname!)
            
            let type = mappingDict?[name] ?? ""
            
            infoDict[name] = type
        }
        
        free(properties)
        
        // 写入缓冲池
        modelCache["\(cls)"] = infoDict
        
        return infoDict
    }
    
    /// 模型缓冲，[类名: 模型信息字典]
    var modelCache = [String: [String: String]]()
}

extension Dictionary {
    ///  将字典合并到当前字典
    mutating func merge<K, V>(dict: [K: V]) {
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}
