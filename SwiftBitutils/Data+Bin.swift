//
//  Data+Bin.swift
//  AthleteApp
//
//  Created by GK on 2020.05.16..
//  Copyright © 2020. ArcSecond, Inc. All rights reserved.
//
//  Source: https://stackoverflow.com/a/52600783/511878

import Foundation

extension Data {
    /// A hexadecimal string representation of the bytes.
    func binEncodedString() -> String {
        return self.map { String($0, radix: 2).frontPadding(toLength: 8, withPad: "0", startingAt: 0) + " " }.joined()
    }
}

extension UInt16 {
    /// A hexadecimal string representation of the bytes.
    func binEncodedString(length: Int = 16) -> String {
        return String(self.littleEndian, radix: 2).frontPadding(toLength: length, withPad: "0", startingAt: 0)
    }
}

