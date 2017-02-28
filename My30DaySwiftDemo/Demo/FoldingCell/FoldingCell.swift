//
//  FoldingCell.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/27.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

class FoldingCell: BaseCell {
    
    func CellAnimation(isOpen:Bool) -> Void {
        if isOpen {
            containerOne.isHidden = true
            containerTwo.isHidden = false
            openAnimation()
        }else{
            containerOne.isHidden = false
            containerTwo.isHidden = true
            closeAnimation()
        }
    }
    
    
    func openAnimation() {
        
    }
    
    func closeAnimation() {
        
    }
    
    var containerOne:UIView!//状态1
    var containerTwo:UIView!//状态2
    
    var one:UIView!
    var two:UIView!
    var three:UIView!
    var four:UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerOne = UIView.init()
        containerOne.backgroundColor = UIColor.red
        contentView.addSubview(containerOne)
        
        containerTwo = UIView.init()
        containerTwo.backgroundColor = UIColor.yellow
        containerTwo.isHidden = true
        contentView.addSubview(containerTwo)
        containerTwo.clipsToBounds = true
        
        one = UIView.init()
        one.backgroundColor = UIColor.blue
        containerTwo.addSubview(one)
        
        two = UIView.init()
        two.backgroundColor = UIColor.black
        containerTwo.addSubview(two)
        
        three = UIView.init()
        three.backgroundColor = UIColor.brown
        containerTwo.addSubview(three)

        four = UIView.init()
        four.backgroundColor = UIColor.gray
        containerTwo.addSubview(four)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerOne.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        containerTwo.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        one.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        two.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(one.snp.bottom)
            make.height.equalTo(80)
        }
        
        three.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(two.snp.bottom)
            make.height.equalTo(40)
        }
        
        four.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(three.snp.bottom)
            make.height.equalTo(40)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
