//
//  NextBrick.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/7.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class NextBrick: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(NextBrick.newBrickGenerated), name: NSNotification.Name(rawValue: Swiftris.NewBrickDidGenerateNotification),object: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func newBrickGenerated() {
        self.setNeedsDisplay()
    }
    
     override func draw(_ rect: CGRect) {
        let gap = 1 * CGFloat(GameBoard.smallBrickSize)
        var top = 0.5 * CGFloat(GameBoard.smallBrickSize)
    
        for brick in Brick.nextBricks {
            let brickWidth = (brick.right().x+1) * CGFloat(GameBoard.smallBrickSize)
            let brickHeight = brick.bottom().y * CGFloat(GameBoard.smallBrickSize)
            let left = (rect.size.width - brickWidth)/2
            for p in brick.points {
                let r = Int(p.y)
                let c = Int(p.x)
                self.drawAt(top: top, left:left, row:r, col: c, color:brick.color)
            }
            top += brickHeight
            top += gap
        }
    }
    
    func drawAt(top:CGFloat, left:CGFloat, row:Int, col:Int, color:UIColor) {
        let context = UIGraphicsGetCurrentContext()!
        let block = CGRect(
            x: left + CGFloat(col*GameBoard.gap + col*GameBoard.smallBrickSize),
            y: top + CGFloat(row*GameBoard.gap + row*GameBoard.smallBrickSize),
            width: CGFloat(GameBoard.smallBrickSize),
            height: CGFloat(GameBoard.smallBrickSize)
        )
        
        if color == GameBoard.EmptyColor {
            GameBoard.strokeColor.set()
            context.fill(block)
        } else {
            color.set()
            UIBezierPath(roundedRect: block, cornerRadius: 1).fill()
        }
    }
    
    @discardableResult
    func update(_ selected:Bool) -> GameState {
        var gameState = GameState.play
        if selected {
            gameState = GameState.play
        } else {
            gameState = GameState.pause
        }
        return gameState
    }
    
    func prepare() {
        self.clearButtons()
        self.clearNextBricks()
    }
    
    func clearButtons() {
        self.update(false)
    }
    
    func clearNextBricks() {
        Brick.nextBricks = [Brick]()
        self.setNeedsDisplay()
    }
}
