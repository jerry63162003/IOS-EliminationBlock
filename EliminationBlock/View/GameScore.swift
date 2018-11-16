//
//  GameScore.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/7.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class GameScore: UIView {
    var gameScore = 0
    var scoreLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scoreLabel.textColor = UIColor(red:0.39, green:0.12, blue:0.00, alpha:1.0)
        scoreLabel.text = "\(gameScore)"
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.minimumScaleFactor = 0.9
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        scoreLabel.textAlignment = .center
        self.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(5)
            make.centerY.equalTo(self).offset(-10)
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(GameScore.update),
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
        gameScore = 0
        update()
    }
    
    @objc func update() {
        gameScore = defaults.integer(forKey: "NowScores")
        scoreLabel.text = "\(gameScore)"
    }
}
