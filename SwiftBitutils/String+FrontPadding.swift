//
//  String+FrontPadding.swift
//  AthleteApp
//
//  Created by GK on 2020.05.16..
//  Copyright © 2020. ArcSecond, Inc. All rights reserved.
//

import Foundation

extension String {
    /// Add leading zeros or other characters and pad your string to a given length
    /// - Parameters:
    ///   - length: The desired length in characters
    ///   - pad: the character to pad with. Use 1 character length strings only
    ///   - index: Start index
    /// - Returns: A padded string
    func frontPadding(toLength length: Int, withPad pad: String, startingAt index: Int) -> String {
        return String(String(self.reversed()).padding(toLength: length, withPad: pad, startingAt: index).reversed())
    }
}
