//
//  SoundFile.swift
//  wizardMath
//
//  Created by James Wallace on 10/8/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation

public protocol SoundFile {
    var filename: String { get }
    var type: String { get }
}

public struct Music: SoundFile {
    public var filename: String
    public var type: String
}

public struct Effect: SoundFile {
    public var filename: String
    public var type: String
}
