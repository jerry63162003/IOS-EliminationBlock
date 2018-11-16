//
//  SoundManager.swift
//  EliminationBlock
//
//  Created by user04 on 2018/9/7.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit
import AVFoundation

class SoundManager: NSObject {
   
    fileprivate var bgmPlayer:AVAudioPlayer?
    fileprivate var effectPlayer:AVAudioPlayer?
    fileprivate var gameOverPlayer:AVAudioPlayer?
    fileprivate let isMusic = GameConfig.shared.isGameMusic
    fileprivate let isSound = GameConfig.shared.isGameSound
    
    override init() {
        super.init()
        self.bgmPlayer = self.makePlayer("tetris_original", ofType: "mp3")!
        self.bgmPlayer?.numberOfLoops = Int.max
        self.bgmPlayer?.volume = 0.1
        
        self.effectPlayer = self.makePlayer("fall", ofType: "mp3")!
        self.effectPlayer?.volume = 1
 
        self.gameOverPlayer = self.makePlayer("gameover", ofType: "mp3")!
        self.gameOverPlayer?.volume = 1
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategorySoloAmbient)
        } catch {}
    }
    
    deinit {
        debugPrint("deinit SoundManager")
    }
    
    fileprivate func makePlayer(_ name:String, ofType:String) -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: name, ofType: ofType) {
            let url = URL(fileURLWithPath: path)
            do {
                return try AVAudioPlayer(contentsOf: url)
            } catch {}
        }
        return nil
    }
    
    func playBGM() {
        if isMusic {
            self.bgmPlayer?.play()
        }
    }
    
    func pauseBGM() {
        self.bgmPlayer?.pause()
    }
    
    func stopBGM() {
        self.bgmPlayer?.stop()
        self.bgmPlayer?.currentTime = 0
    }
    
    func dropBrick() {
        if isSound {
            self.effectPlayer?.prepareToPlay()
            self.effectPlayer?.play()
        }
    }
    
    func gameOver() {
        if isMusic {
            self.gameOverPlayer?.prepareToPlay()
            self.gameOverPlayer?.play()
        }
    }
    
    func clear() {
        self.effectPlayer?.stop()
        self.gameOverPlayer?.stop()
        self.bgmPlayer?.stop()
    }
}
