//
//  RegularExpressionExtensions.swift
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

extension NSRegularExpression {
    public func firstMatch(inString string: String, options: NSRegularExpression.MatchingOptions, range: StringRange? = nil) -> TextCheckingResult? {
        let range = range ?? string.stringRange
        let nsRange = string.nsRange(from: range)!
        return firstMatch(in: string, options: options, range: nsRange)
    }

    public func matchedSubstrings(inString string: String, options: NSRegularExpression.MatchingOptions = [], range: StringRange? = nil) -> [String]? {
        var result: [String]! = nil
        if let textCheckingResult = self.firstMatch(inString: string, options: options, range: range) {
            result = [String]()
            for range in textCheckingResult.captureRanges(in: string) {
                let matchText = String(string[range])
                result.append(matchText)
            }
        }
        return result
    }
}
