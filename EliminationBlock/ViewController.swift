//
//  ViewController.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/7.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var highScore: UILabel!
    let gameConfig = GameConfig.shared
    let soundManager = SoundManager()
    var modeButtonList: [UIButton] = []
    
    lazy var settingView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image:#imageLiteral(resourceName: "设置bg"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "清除"), for: .normal)
        cancelButton.tag = 31
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(18)
            make.right.equalTo(bgImage).offset(10)
        })
        
        let label1 = UILabel()
        label1.textColor = UIColor.black
        label1.text = "音乐"
        label1.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(label1)
        label1.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(57)
            make.top.equalTo(bgImage).offset(117)
        })
        
        let label2 = UILabel()
        label2.textColor = UIColor.black
        label2.text = "音效"
        label2.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(label2)
        label2.snp.makeConstraints({ (make) in
            make.left.equalTo(label1)
            make.top.equalTo(label1.snp.bottom).offset(38)
        })
        
        let musicButton = UIButton()
        musicButton.isSelected = gameConfig.isGameMusic
        musicButton.setImage(#imageLiteral(resourceName: "按钮"), for: .selected)
        musicButton.setImage(#imageLiteral(resourceName: "按钮-1"), for: .normal)
        musicButton.tag = 10
        musicButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(musicButton)
        musicButton.snp.makeConstraints({ (make) in
            make.left.equalTo(label1.snp.right).offset(19)
            make.centerY.equalTo(label1)
        })
        
        let soundButton = UIButton()
        soundButton.isSelected = gameConfig.isGameSound
        soundButton.setImage(#imageLiteral(resourceName: "按钮"), for: .selected)
        soundButton.setImage(#imageLiteral(resourceName: "按钮-1"), for: .normal)
        soundButton.tag = 11
        soundButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(soundButton)
        soundButton.snp.makeConstraints({ (make) in
            make.left.equalTo(label2.snp.right).offset(19)
            make.centerY.equalTo(label2)
        })
        
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        button.tag = 30
        button.setImage(#imageLiteral(resourceName: "关于我们"), for: .normal)
        bgImage.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(label2.snp.bottom).offset(40)
        }
        
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScore.text = "最高分: \(defaults.integer(forKey: "HighScores"))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openWebView() {
        let webview = WebViewController()
        webview.urlStr = "http://static.qqacar.com/Block/index.html"
        var top = UIApplication.shared.keyWindow?.rootViewController
        while ((top?.presentedViewController) != nil) {
            top = top?.presentedViewController
        }
        top?.present(webview, animated: true, completion: nil)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        
        if sender.tag == 12 {
            openSetting()
        }
        
        if sender.tag == 30 {
            openWebView()
        }
        
        if sender.tag == 31{
            settingView.removeFromSuperview()
        }
    }
    
    @objc func settingClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            gameConfig.isGameMusic = sender.isSelected
        }
        if sender.tag == 11 {
            gameConfig.isGameSound = sender.isSelected
        }
    }
    
    func openSetting() {
        view.addSubview(settingView)
        settingView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }
    
}
