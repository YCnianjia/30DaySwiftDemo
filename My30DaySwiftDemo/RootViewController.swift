//
//  ViewController.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/17.
//  Copyright © 2017年 王佳佳. All rights reserved.
//
import SnapKit
import UIKit

class RootViewController: BaseViewController {
    
    fileprivate var dataSource:[SkipModel] = []
    fileprivate var tabelView:UITableView!
    
    fileprivate let CellIdetifier = "CellIdetifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SwiftDemo"
        
        setLeftBarToNil()
        
        dealDate()
    }
    
    // MARK:  - Data
    override func dealDate() {
//        dataSource.append(SkipModel.addModel(title: "FoldingCell", controlName: "FoldingCellController", parameters: nil))
        dataSource.append(SkipModel.addModel(title: "StopWatch", controlName: "StopWatchController", parameters: nil))
        tabelView.reloadData()
    }
    
    // MARK:  - UI
    override func setSubView(){
        let tabel:UITableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        tabel.dataSource = self
        tabel.delegate = self
        view.addSubview(tabel)
        tabelView = tabel
    }
    
    // MARK:  - Delegate
    
    // MARK:  - Event
    
    // MARK:  - Methed
}

extension RootViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdetifier)
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: CellIdetifier)
        }
        let model:SkipModel = dataSource[indexPath.row]
        cell?.textLabel?.text = model.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabelView.deselectRow(at: indexPath, animated: true)
        let model:SkipModel = dataSource[indexPath.row]
        SkipViewModel.gotoVC(skipModel: model, formVC: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


