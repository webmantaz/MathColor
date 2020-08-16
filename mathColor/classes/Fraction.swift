//
//  Fraction.swift
//  mathColor
//
//  Created by James Wallace on 8/15/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation

class Fraction {
    var numerator = 0
    var denominator = 0
    
    init(numerator: Int, denominator: Int)
    {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    init()
    {
        numerator = 1
        denominator = 1
    }
    
}
