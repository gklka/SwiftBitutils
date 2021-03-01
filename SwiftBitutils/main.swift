//
//  main.swift
//  SwiftBitutils
//
//  Created by GK on 2021.03.01..
//

import Foundation

let bytes: [UInt8] = [
    0b0000_0001,
    0b0000_0010,
    0b0000_0011
]
var data = Data(bytes: bytes, count: 3)
let ones = Data(repeating: 0xff, count: 3)
let zeros = Data(repeating: 0x00, count: 3)

// Display original values
print(data.binEncodedString())
print(ones.binEncodedString())
print(zeros.binEncodedString())

print(data.hexEncodedString())
print(ones.hexEncodedString())
print(zeros.hexEncodedString())

// Set specific bits
data[byte: 0, bit: 7] = false
data[byte: 1, bit: 6] = false
data[byte: 2, bit: 6] = false
data[byte: 2, bit: 7] = false

data[bit: 7] = true
data[bit: 15] = true
data[bit: 23] = true

// Set specific range of bits
data[bitRange: 8...15] = false

// Get specific bits
print(data[bit: 0])
print(data[bit: 7])
print(data[bit: 14])
print(data[bit: 22])
print(data[bit: 23])

// Shift Data
data = data << 3
data = data >> 6
