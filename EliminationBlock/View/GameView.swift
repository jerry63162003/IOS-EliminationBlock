//
//  GameView.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/7.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class GameView: UIView {
    var gameBoard = GameBoard(frame:CGRect.zero)
    
    init(_ superView:UIView) {
        super.init(frame: superView.bounds)
        superView.backgroundColor = UIColor.clear
        superView.addSubview(self)
        
        // background color
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.gameBoard)
        gameBoard.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(screenWidth*(220/375))
            make.height.equalTo(screenHeight*(347/667))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("deinit GameView")
    }
    
    func clear() {
        self.gameBoard.clear()
    }
    func prepare() {
        self.gameBoard.clear()
    }
}
