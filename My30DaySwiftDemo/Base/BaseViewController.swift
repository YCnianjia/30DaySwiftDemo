//
//  BaseViewController.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/17.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white;
        
        setLeftBar()
        setSubView()
    }
    
    deinit {
//        NSString * nameString = NSStringFromClass([self class]);
        let controlName = NSStringFromClass(self.classForCoder)
        print(controlName + ":页面释放。。。")
    }
    
    // MARK:  - Data
    func dealDate(){
        
    }
    
    // MARK:  - UI
    func setSubView(){
        
    }
    // MARK:  - Delegate
    
    // MARK:  - Event
    @objc func backAction(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK:  - Methed
    func setLeftBarToNil() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
    }
    
    func setLeftBar(){
        let barButtonItem:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "item_back_gray"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = barButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
