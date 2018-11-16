//
//  GameConfig.swift
//  MathsMaster
//
//  Created by roy on 2018/7/23.
//  Copyright © 2018年 roy. All rights reserved.
//

import UIKit
public let defaults: UserDefaults = UserDefaults.standard
public let screenWidth: CGFloat = UIScreen.main.bounds.size.width
public let screenHeight: CGFloat = UIScreen.main.bounds.size.height

let uGameMusic = "isGameMusic"
let uGameSound = "isGameSound"

class GameConfig: NSObject {
    static let shared = GameConfig()

    var isGameMusic = defaults.object(forKey: uGameMusic) as? Bool ?? true {
        didSet {
            defaults.set(isGameMusic, forKey: uGameMusic)
            defaults.synchronize()
        }
    }
    var isGameSound = UserDefaults.standard.object(forKey: uGameSound) as? Bool ?? true {
        didSet {
            defaults.set(isGameSound, forKey: uGameSound)
            defaults.synchronize()
        }
    }

}
