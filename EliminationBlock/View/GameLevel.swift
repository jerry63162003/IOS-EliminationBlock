//
//  GameLevel.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/8.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class GameLevel: UIView {
    
    var gameLevel = 1
    fileprivate var levelLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.textColor = UIColor(red:0.39, green:0.12, blue:0.00, alpha:1.0)
        levelLabel.text = "\(gameLevel)"
        levelLabel.font = Swiftris.GameFont(20)
        levelLabel.adjustsFontSizeToFitWidth = true
        levelLabel.minimumScaleFactor = 0.9
        levelLabel.textAlignment = .center
        self.addSubview(levelLabel)
        levelLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(5)
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(GameLevel.update),
                                               name: NSNotification.Name(rawValue: Swiftris.LineClearNotification),
                                               object: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func clear() {
        self.gameLevel = 1
        self.update()
    }
    
    @objc func update() {
        gameLevel = defaults.integer(forKey: "level")
        self.levelLabel.text = "\(gameLevel)"
    }
    
}
