//
//  TextCheckingResultExtensions.swift
//  WolfStrings
//
//  Created by Wolf McNally on 1/5/16.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

extension TextCheckingResult {
    public func range(atIndex index: Int, inString string: String) -> StringRange {
        return string.stringRange(from: range(at: index))!
    }

    public func captureRanges(inString string: String) -> [StringRange] {
        var result = [StringRange]()
        for i in 1 ..< numberOfRanges {
            result.append(range(atIndex: i, inString: string))
        }
        return result
    }
}

extension TextCheckingResult {
    public func get(atIndex index: Int, inString string: String) -> RangeReplacement {
        let range = self.range(atIndex: index, inString: string)
        let text = String(string[range])
        return (range, text)
    }
}
