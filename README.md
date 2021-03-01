# Swift utilities for direct bit manipulation

Here you can find a bunch of useful extensions for Swift language when you need to manipulate bits of data directly.

## Contents

### Data+Bin

Display `Data` objects as bits. For example:

```
00000001 00000010 00000011 
11111111 11111111 11111111 
00000000 00000000 00000000
```

#### Usage

```
let data = Data(...)
let string = data.binEncodedString()
print(string)
```

### Data+Hex

Display contents of `Data` objects as hexadecimal numbers. For example:

```
010203
ffffff
000000
```

#### Usage

```
let data = Data(...)
let string = data.hexEncodedString()
print(string)
```

### Data+Bits

Access individual bits of a `Data` object with a convenient `[]` subscript accessor. To don't conflict with the byte accessor found in `Foundation`, you have to use it by writing `bit:` explicitly. Returned values are booleans, and you can set also ranges. (There is no implementation for accessing ranges currently.)

There are also basic implementations of shifting the entire `Data` object by 0-7 bits left or right using the `<<` and `>>` operators, just like scalar types. Overflowing is handled too.

#### Set specific bits

```swift
data[byte: 0, bit: 7] = false
data[byte: 1, bit: 6] = false
data[byte: 2, bit: 6] = false
data[byte: 2, bit: 7] = false

data[bit: 7] = true
data[bit: 15] = true
data[bit: 23] = true
```

#### Set specific range of bits

```swift
data[bitRange: 8...15] = false
```

#### Get specific bits

```swift
print(data[bit: 0])
print(data[bit: 7])
print(data[bit: 14])
print(data[bit: 22])
print(data[bit: 23])
```

#### Shift Data

```swift
data = data << 3
data = data >> 6
```

## Limitations

Word length is fixed to 8 bits. I did not need any other, so consider implement it better if you have different needs.
