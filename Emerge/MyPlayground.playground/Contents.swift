import UIKit


// WHY ARE STRINGS SO HARD!?

let str = "Four score and seven years ago"

var ranger = Range(start: str.startIndex, end: str.startIndex.advancedBy(6))

let subby = str.substringWithRange(ranger)


ranger.startIndex = str.startIndex.advancedBy(4)

print(str.substringWithRange(ranger))

