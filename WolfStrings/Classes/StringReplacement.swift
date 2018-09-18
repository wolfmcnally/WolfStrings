//
//  StringReplacement.swift
//  WolfStrings
//
//  Created by Wolf McNally on 6/24/17.
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

public typealias Replacements = [String: String]

extension String {
    public func replacing(replacements: [RangeReplacement]) -> (string: String, ranges: [StringRange]) {
        let source = self
        var target = self
        var targetReplacedRanges = [StringRange]()
        let sortedReplacements = replacements.sorted { $0.0.lowerBound < $1.0.lowerBound }

        var totalOffset = 0
        for (sourceRange, replacement) in sortedReplacements {
            let replacementCount = replacement.count
            let rangeCount = source.distance(from: sourceRange.lowerBound, to: sourceRange.upperBound)
            let offset = replacementCount - rangeCount

            let newTargetStartIndex: StringIndex
            let originalTarget = target
            do {
                let targetStartIndex = target.convert(index: sourceRange.lowerBound, fromString: source, offset: totalOffset)
                let targetEndIndex = target.index(targetStartIndex, offsetBy: rangeCount)
                let targetReplacementRange = targetStartIndex..<targetEndIndex
                target.replaceSubrange(targetReplacementRange, with: replacement)
                newTargetStartIndex = target.convert(index: targetStartIndex, fromString: originalTarget)
            }

            targetReplacedRanges = targetReplacedRanges.map { originalTargetReplacedRange in
                let targetReplacedRange = target.convert(range: originalTargetReplacedRange, fromString: originalTarget)
                guard targetReplacedRange.lowerBound >= newTargetStartIndex else {
                    return targetReplacedRange
                }
                let adjustedStart = target.index(targetReplacedRange.lowerBound, offsetBy: offset)
                let adjustedEnd = target.index(adjustedStart, offsetBy: replacementCount)
                return adjustedStart..<adjustedEnd
            }
            let targetEndIndex = target.index(newTargetStartIndex, offsetBy: replacementCount)
            let targetReplacedRange = newTargetStartIndex..<targetEndIndex
            targetReplacedRanges.append(targetReplacedRange)
            totalOffset += offset
        }

        return (target, targetReplacedRanges)
    }
}

extension String {
    public func replacing(matchesTo regex: NSRegularExpression, usingBlock block: (RangeReplacement) -> String) -> (string: String, ranges: [StringRange]) {
        let results = (regex ~?? self).map { match -> RangeReplacement in
            let matchRange = match.range(atIndex: 0, inString: self)
            let substring = String(self[matchRange])
            let replacement = block((matchRange, substring))
            return (matchRange, replacement)
        }
        return replacing(replacements: results)
    }
}

// (?:(?<!\\)#\{(\w+)\})
// The quick #{color} fox #{action} over #{subject}.
private let placeholderReplacementRegex = try! ~/"(?:(?<!\\\\)#\\{(\\w+)\\})"

extension String {
    public func replacingPlaceholders(with replacements: Replacements) -> String {
        var replacementsArray = [RangeReplacement]()
        let matches = placeholderReplacementRegex ~?? self
        for match in matches {
            let matchRange = stringRange(from: match.range)!
            let placeholderRange = stringRange(from: match.range(at: 1))!
            let replacementName = String(self[placeholderRange])
            if let replacement = replacements[replacementName] {
                replacementsArray.append((matchRange, replacement))
            } else {
                fatalError("Replacement in \"\(self)\" not found for placeholder \"\(replacementName)\".")
            }
        }

        return replacing(replacements: replacementsArray).string
    }
}
