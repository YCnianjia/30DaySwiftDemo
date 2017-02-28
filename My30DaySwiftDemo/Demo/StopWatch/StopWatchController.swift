//
//  StopWatchController.swift
//  My30DaySwiftDemo
//
//  Created by 王佳佳 on 2017/2/27.
//  Copyright © 2017年 王佳佳. All rights reserved.
//

import UIKit

class StopWatchController: BaseViewController {
    
    var starButton:UIButton!
    var pauseButton:UIButton!
    var resetButton:UIButton!
    var valueLable:UILabel!
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:  - Data
    
    // MARK:  - UI
    override func setSubView() {
        super.setSubView()
        view.backgroundColor = UIColor.black
        
        createControls()
    }
    
    private func createControls(){
        resetButton = UIButton.init()
        resetButton.setTitle("Reset", for: UIControlState.normal)
        resetButton.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        view.addSubview(resetButton)
        
        valueLable = UILabel.createLabel(frame: CGRect.zero, text: "0.0", color: UIColor.white, font: 30, textAlignment: NSTextAlignment.center)
        view.addSubview(valueLable)
        
        starButton = UIButton.init()
        starButton.setImage(UIImage.init(named: "play"), for: UIControlState.normal)
        starButton.backgroundColor = UIColor.blue
        starButton.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        view.addSubview(starButton)
        
        pauseButton = UIButton.init()
        pauseButton.setImage(UIImage.init(named: "pause"), for: UIControlState.normal)
        pauseButton.backgroundColor = UIColor.green
        pauseButton.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        view.addSubview(pauseButton)
    }
    
    // MARK:  - Event
    @objc func buttonClick(sender:UIButton){
        
        if sender == starButton {
            starTimer()
        }else if sender == pauseButton{
            stopTimer()
        }else if sender == resetButton{
            valueLable.text = "0.0"
            stopTimer()
        }
        
    }
    
    @objc func timerMethod(){
        if Float.init(valueLable.text!) != nil {
            var currentTime:Float = Float.init(valueLable.text!)!
            currentTime = currentTime + 0.1
            valueLable.text = "\(currentTime)"
        }
    }
    
    // MARK:  - Methed
    private func starTimer(){
        //防止定时器的重复创建
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerMethod), userInfo: nil, repeats: true)
        }
    }
    private func stopTimer(){
        //防止定时器重复释放
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    // MARK:  - 页面布局
    override func viewDidLayoutSubviews() {
        resetButton.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(35)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(64 + 12)
        }
        
        valueLable.snp.makeConstraints { (make) in
            make.top.equalTo(resetButton.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        
        starButton.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(valueLable.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        pauseButton.snp.makeConstraints { (make) in
            make.top.width.bottom.equalTo(starButton)
            make.left.equalTo(starButton.snp.right)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
