//
//  AudioPlayerImplementation.swift
//  wizardMath
//
//  Created by James Wallace on 10/8/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation
import AVKit

class AudioPlayerImpl {
    
    private var currentMusicPlayer: AVAudioPlayer?
    private var currentEffectPlayer: AVAudioPlayer?
    var musicVolume: Float = 1.0 {
        didSet { currentMusicPlayer?.volume = musicVolume }
    }
    var effectsVolume: Float = 1.0
}

extension AudioPlayerImpl: AudioPlayer {
    
    func play(music: Music, timeToPlay: TimeInterval) {
        currentMusicPlayer?.stop()
        guard let newPlayer = try? AVAudioPlayer(soundFile: music) else { return }
        newPlayer.volume = musicVolume
        let lengthOfMusic = newPlayer.duration
        let loops = Int(timeToPlay / lengthOfMusic) + 1
        newPlayer.numberOfLoops = loops
        newPlayer.play()
        currentMusicPlayer = newPlayer
    }
    
    func pause(music: Music) {
        currentMusicPlayer?.pause()
    }
    
    func stop(music: Music) {
        currentMusicPlayer?.stop()
    }
    
     
    func play(effect: Effect) {
        guard let effectPlayer = try? AVAudioPlayer(soundFile: effect) else { return }
        effectPlayer.volume = effectsVolume
        effectPlayer.play()
        currentEffectPlayer = effectPlayer
    }
}
