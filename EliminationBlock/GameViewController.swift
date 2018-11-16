//
//  GameViewController.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/6.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var lineCountView: UIView!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var GameMainView: UIView!
    @IBOutlet weak var nextBrickView: UIView!
    @IBOutlet weak var gameScoreView: UIView!
    @IBOutlet weak var gmaeLevelView: UIView!
    
    var swiftris: Swiftris!
    let clearLine = ClearLine(frame:CGRect.init(x: 0, y: 0, width: screenWidth*(77/375.0), height: screenHeight*(77/667.0)))
    let gamelevel = GameLevel(frame:CGRect.init(x: 0, y: 0, width: screenWidth*(77/375.0), height: screenHeight*(77/667.0)))
    
    let gameScore = GameScore(frame:CGRect.init(x: 0, y: 0, width: screenWidth*(146/375), height: screenHeight*(137/667)))
    let nextBrick = NextBrick(frame:CGRect.zero)
    let smallBrickViewSize = UIScreen.main.bounds.size.width*(10/375.0) * 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBrickView.addSubview(nextBrick)
        nextBrick.snp.makeConstraints { (make) in
            make.centerX.equalTo(nextBrickView)
            make.centerY.equalTo(nextBrickView).offset(2)
            make.width.height.equalTo(smallBrickViewSize)
        }
        lineCountView.addSubview(clearLine)
        gmaeLevelView.addSubview(gamelevel)
        gameScoreView.addSubview(gameScore)
        
        highScore.text = "\(defaults.integer(forKey: "HighScores"))"
        self.initializeGame()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(GameViewController.gameOver(_:)),
                                               name: NSNotification.Name(rawValue: Swiftris.GameOverNotification),
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.swiftris.deinitGame()
    }

    deinit {
        self.swiftris.deinitGame()
    }
    
    @objc func gameOver(_ noti:Notification) {
        performSegue(withIdentifier: "toGameOver", sender: gameScore.scoreLabel.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameOver" {
            let vc = segue.destination as! GameOverViewController
            vc.score = gameScore.scoreLabel.text!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nextBrick.clearNextBricks()
        let gameState = GameState.play
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Swiftris.GameStateChangeNotification),
            object: nil,
            userInfo: ["gameState":NSNumber(value: gameState.rawValue as Int)]
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initializeGame() {
        // after layout pass, ensure GameView to make
        DispatchQueue.main.async {
            let gameView = GameView(self.GameMainView)
            gameView.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.GameMainView.snp.centerX)
                make.centerY.equalTo(self.GameMainView.snp.centerY).offset(-5)
            })
            self.swiftris = Swiftris(gameView: gameView)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        switch sender.tag {
            //back
        case 1:
            dismiss(animated: true, completion: nil)
            break
            
            //pause
        case 2:
            sender.isSelected = !sender.isSelected
            var gameState = GameState.play
            if sender.isSelected {
                gameState = GameState.pause
            } else {
                gameState = GameState.play
            }
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: Swiftris.GameStateChangeNotification),
                object: nil,
                userInfo: ["gameState":NSNumber(value: gameState.rawValue as Int)]
            )
            break
            
            //left
        case 3:
            swiftris.gameView.gameBoard.updateX(-1)
            break
            
            //rotate
        case 4:
            swiftris.rotateBrick()
            break
        
            //right
        case 5:
            swiftris.gameView.gameBoard.updateX(1)
            break
            
            //down
        case 6:
           swiftris.gameView.gameBoard.dropBrick()
            break
            
        default:
            break
        }
    }

}
