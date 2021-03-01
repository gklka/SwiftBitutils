//
//  Data+Bits.swift
//  bittest
//
//  Created by GK on 2021.02.26..
//

import Foundation

let WordLength: Int = 8

extension Data {
    /// Usage: `data[bit: n]`, where `n` is the index of the bit in the data. Indexes start with `0`
    subscript(bit bitIndex: Int) -> Bool {
        get {
            let bitInByteIndex: Int = bitIndex % WordLength
            let byteIndex: Int = (bitIndex-bitInByteIndex) / WordLength
            return self[byte: byteIndex, bit: UInt8(bitInByteIndex)]
        }
        set {
            let bitInByteIndex: Int = bitIndex % WordLength
            let byteIndex: Int = (bitIndex-bitInByteIndex) / WordLength
            self[byte: byteIndex, bit: UInt8(bitInByteIndex)] = newValue
        }
    }
    
    /// Usage: `data[byte: b, bit: n]`, where `b` is the index of byte (word) and `n` is the index of the bit in the byte. Indexes start with `0`
    subscript(byte byteIndex: Int, bit bitIndex: UInt8) -> Bool {
        get {
            let byte = self[byteIndex]
            let mask: UInt8 = 0b1000_0000 >> bitIndex
            return (byte & mask) == mask
        }
        set {
            let mask: UInt8 = 0b1000_0000 >> bitIndex
            if newValue {
                self[byteIndex] |= mask // Set bit to 1
            } else {
                self[byteIndex] &= ~mask // Set bit to 0
            }
        }
    }
    
    /// Usage: `data[bitRange: 8...15]` where `bitRange` is the index of bits starting with 0. The resulting Data object will contain enough bytes to represent the answer filled with zeros.
    subscript(bitRange bitRange: ClosedRange<Int>) -> Data {
        get {
            let additionalByte = bitRange.count % WordLength == 0 ? 0 : 1
            var output = Data(repeating: 0b0000_0000, count: bitRange.count / WordLength + additionalByte)
            
            for i in 0..<bitRange.count {
                output[bit: i] = self[bit: i + bitRange.lowerBound]
            }
            
            return output
        }
        set {
            for i in 0..<bitRange.count {
                self[bit: i + bitRange.lowerBound] = newValue[bit: i]
            }
        }
    }
    
    /// Usage: `data[bitRange: 8...15] = false` where `bitRange` is the index of bits starting with 0. Sets the bits in the given range to the given value. Setter only.
    subscript(bitRange bitRange: ClosedRange<Int>) -> Bool {
        get {
            assertionFailure("Getter makes no sense")
            return false
        }
        set {
            for i in 0..<bitRange.count {
                self[bit: i + bitRange.lowerBound] = newValue
            }
        }
    }
    
    /// Shift left with 0...7 bits
    static func <<(lhs: Data, rhs: UInt8) -> Data {
        let shift = Int(rhs) % WordLength
        if shift == 0 { return lhs }

        var output = Data(repeating: 0x00, count: 1)
        output.append(lhs)
        
        for i in 0...(lhs.count * WordLength - 1) {
            output[bit: (WordLength - shift + i)] = lhs[bit: i]
        }
        for i in (output.count * WordLength - shift)...(output.count * WordLength - 1) {
            output[bit: i] = false
        }
        
        return output
    }

    /// Shift right with 0...7 bits
    static func >>(lhs: Data, rhs: UInt8) -> Data {
        let shift = Int(rhs) % WordLength
        if shift == 0 { return lhs }

        var output = Data(lhs)
        output.append(0x00)
        
        for i in 0...(lhs.count * WordLength - 1) {
            output[bit: (shift + i)] = lhs[bit: i]
        }
        for i in 0...shift-1 {
            output[bit: i] = false
        }
        
        return output
    }
}
