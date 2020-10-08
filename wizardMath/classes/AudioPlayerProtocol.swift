//
//  AudioPlayerProtocol.swift
//  wizardMath
//
//  Created by James Wallace on 10/8/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation


protocol AudioPlayer {
    
    var musicVolume: Float { get set }
    func play(music: Music)
    func pause(music: Music)
    
    var effectsVolume: Float { get set }
    func play(effect: Effect)
}
