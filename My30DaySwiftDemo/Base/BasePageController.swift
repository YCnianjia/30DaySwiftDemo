//
//  BasePageController.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/27.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

class BasePageController: BaseViewController {
    
    var tabelView:UITableView!
    
    var dataSource:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:  - Data
    
    // MARK:  - UI
    override func setSubView() {
        super.setSubView()
    }
    // MARK:  - Delegate
    
    // MARK:  - Event
    
    // MARK:  - Methed
    func createTabelView(frame:CGRect, style:UITableViewStyle) -> Void{
        tabelView = UITableView.init(frame: frame, style: style)
        tabelView.tableFooterView = UIView.init()
        view.addSubview(tabelView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

