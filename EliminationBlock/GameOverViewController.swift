//
//  GameOverViewController.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/6.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    var score: String = ""
    let nextBrick = NextBrick(frame:CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        commitInit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func commitInit() {
        scoreLabel.text = "得分: \(score)"
    }
    
}
