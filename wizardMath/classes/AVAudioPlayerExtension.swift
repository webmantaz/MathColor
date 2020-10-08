//
//  AVAudioPlayerExtension.swift
//  wizardMath
//
//  Created by James Wallace on 10/8/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation
import AVKit

extension AVAudioPlayer {
    
    public enum AudioPlayerError: Error {
        case fileNotFound
    }
    
    public convenience init(soundFile: SoundFile) throws {
        guard let url = Bundle.main.url(forResource: soundFile.filename, withExtension: soundFile.type) else { throw AudioPlayerError.fileNotFound }
        try self.init(contentsOf: url)
    }
}
