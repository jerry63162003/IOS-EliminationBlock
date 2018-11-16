//
//  ClearLine.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/7.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class ClearLine: UIView {
    
    var lineClearCount = 0
    var score = 0
    var level = 1
    fileprivate var lineClearLabel = UILabel()
    fileprivate var scores = [0, 10, 20, 30, 40]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        lineClearLabel.textColor = UIColor(red:0.39, green:0.12, blue:0.00, alpha:1.0)
        lineClearLabel.text = "\(lineClearCount)"
        lineClearLabel.font = Swiftris.GameFont(20)
        lineClearLabel.adjustsFontSizeToFitWidth = true
        lineClearLabel.minimumScaleFactor = 0.9
        lineClearLabel.textAlignment = .center
        self.addSubview(lineClearLabel)
        lineClearLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(5)
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ClearLine.lineClear(_:)),
                                               name: NSNotification.Name(rawValue: Swiftris.LineClearNotification),
                                               object: nil)
    }
    
    @objc func lineClear(_ noti:Notification) {
        if let userInfo = noti.userInfo as? [String:NSNumber] {
            if let lineCount = userInfo["lineCount"] {
                self.lineClearCount += lineCount.intValue
                score += scores[lineCount.intValue]
                
                if score >= defaults.integer(forKey: "HighScores"){
                    defaults.set(score, forKey: "HighScores")
                }
                defaults.set(score, forKey: "NowScores")
                if score < 100 {
                    level = 1
                    defaults.set(level, forKey: "level")
                } else if score < 200 && score >= 100 {
                    level = 2
                    defaults.set(level, forKey: "level")
                } else if score < 300 && score >= 200 {
                    level = 3
                    defaults.set(level, forKey: "level")
                } else {
                    level = 4
                    defaults.set(level, forKey: "level")
                }
                
                self.update()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func clear() {
        defaults.removeObject(forKey: "level")
        defaults.removeObject(forKey: "NowScores")
        lineClearCount = 0
        self.update()
    }
    
    func update() {
        lineClearLabel.text = "\(lineClearCount)"
    }
    
}
