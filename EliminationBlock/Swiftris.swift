//
//  Swiftris.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/7.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

enum GameState:Int {
    case stop = 0
    case play
    case pause
}

class Swiftris: NSObject {
    // Notification
    static var LineClearNotification                   = "LineClearNotification"
    static var NewBrickDidGenerateNotification         = "NewBrickDidGenerateNotification"
    static var GameStateChangeNotification             = "GameStateChangeNotification"
    static var GameOverNotification                    = "GameOverNotification"
    
    // font
    static func GameFont(_ fontSize:CGFloat) -> UIFont! {
        return UIFont(name: "ChalkboardSE-Regular", size: fontSize)
    }
    
    var gameView: GameView!
    var gameTimer: GameTimer!
    var soundManager = SoundManager()
    var gameState = GameState.stop
    
    required init(gameView:GameView) {
        super.init()
        self.gameView = gameView
        initGame()
    }
    
    deinit {
        debugPrint("deinit Swiftris")
        deinitGame()
    }
    
    fileprivate func initGame() {
        gameTimer = GameTimer(target: self, selector: #selector(Swiftris.gameLoop))
        self.addGameStateChangeNotificationAction(#selector(Swiftris.gameStateChange(_:)))
    }
    
    func deinitGame() {
        stop()
        soundManager.clear()
        removeGameStateChangeNotificationAction()
    }
    
    @objc func gameStateChange(_ noti:Notification) {
        guard let userInfo = noti.userInfo as? [String:NSNumber] else { return }
        guard let rawValue = userInfo["gameState"] else { return }
        guard let toState = GameState(rawValue: rawValue.intValue) else { return }
        
        switch gameState {
        case .play:
            // pause
            if toState == GameState.pause {
                pause()
            }
            // stop
            if toState == GameState.stop {
                stop()
            }
        case .pause:
            // resume game
            if toState == GameState.play {
                play()
            }
            // stop
            if toState == GameState.stop {
                stop()
            }
        case .stop:
            // start game
            if toState == GameState.play {
                prepare()
                play()
            }
        }
    }

    @objc func gameLoop() {
        update()
        gameView.setNeedsDisplay()
    }
    fileprivate func update() {

        self.gameTimer.counter += 1
        
        if gameTimer.counter%10 == 9 {
            let game = gameView.gameBoard.update()
            if game.isGameOver {
                gameOver()
                return
            }
            if game.droppedBrick {
                
                soundManager.dropBrick()
            }
        }
    }
    
    fileprivate func prepare() {
        gameView.prepare()
        gameView.gameBoard.generateBrick()
    }
    fileprivate func play() {
        gameState = GameState.play
        gameTimer.start()
        soundManager.playBGM()
    }
    fileprivate func pause() {
        gameState = GameState.pause
        gameTimer.pause()
        soundManager.pauseBGM()
    }
    fileprivate func stop() {
        gameState = GameState.stop
        gameTimer.pause()
        soundManager.stopBGM()
        gameView.clear()
    }
    fileprivate func gameOver() {
        gameState = GameState.stop
        gameTimer.pause()
        soundManager.stopBGM()
        soundManager.gameOver()
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Swiftris.GameOverNotification),
            object: nil,
            userInfo:nil
        )
    }
    
    func rotateBrick() {
        guard gameState == GameState.play else { return }
        guard let _ = gameView.gameBoard.currentBrick else { return }
        
        gameView.gameBoard.rotateBrick()
    }
    
    fileprivate func addGameStateChangeNotificationAction(_ action:Selector) {
        NotificationCenter.default.addObserver(self,
                                                         selector: action,
                                                         name: NSNotification.Name(rawValue: Swiftris.GameStateChangeNotification),
                                                         object: nil)
    }
    fileprivate func removeGameStateChangeNotificationAction() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
