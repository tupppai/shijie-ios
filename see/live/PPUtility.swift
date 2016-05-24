//
//  PPUtility.swift
//  live
//
//  Created by chenpeiwei on 3/21/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import Foundation

/**
 generate random integer within range
 */

public func randInRange(range: Range<Int>) -> Int {
    // arc4random_uniform(_: UInt32) returns UInt32, so it needs explicit type conversion to Int
    // note that the random number is unsigned so we don't have to worry that the modulo
    // operation can have a negative output
    return  Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
}