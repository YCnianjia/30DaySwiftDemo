//
//  FoldingCellController.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/27.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

class FoldingCellController: BasePageController {
    
    let CELLINDETIFIER = "FoldingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FoldingCell"
        
        dealDate()
        tabelView.reloadData()
    }
    
    // MARK:  - Data
    override func dealDate() {
        super.dealDate()
        let model1:FoldingModel = FoldingModel.init()
        let model2:FoldingModel = FoldingModel.init()
        let model3:FoldingModel = FoldingModel.init()
        dataSource = [model1,model2,model3]
    }
    
    // MARK:  - UI
    override func setSubView() {
        super.setSubView()
        createTabelView(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: SCREENH), style: .plain)
        tabelView.dataSource = self
        tabelView.delegate = self
    }
    
    // MARK:  - Delegate
    
    // MARK:  - Event
    
    // MARK:  - Methed
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FoldingCellController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tabelView.dequeueReusableCell(withIdentifier: CELLINDETIFIER)
        if cell == nil{
            cell = FoldingCell.init(style: UITableViewCellStyle.default, reuseIdentifier: CELLINDETIFIER)
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:FoldingModel = dataSource[indexPath.row] as! FoldingModel
        model.isSelect = !model.isSelect
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        cell.CellAnimation(isOpen: model.isSelect)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model:FoldingModel = dataSource[indexPath.row] as! FoldingModel
        if model.isSelect {
            return 80 + 80 + 40 + 40
        }else{
            return 80
        }
    }
}
