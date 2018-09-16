//
//  StringTransformations.swift
//  WolfStrings
//
//  Created by Wolf McNally on 6/24/17.
//  Copyright © 2017 Wolf McNally
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

private let newlinesRegex = try! ~/"\n"

extension String {
    public func escapingNewlines() -> String {
        return replacing(matchesTo: newlinesRegex) { _ in
            return "\\n"
            }.string
    }

    public func truncated(afterCount count: Int, adding signifier: String? = "…") -> String {
        guard self.count > count else { return self }
        let s = String(self[startIndex..<index(startIndex, offsetBy: count)])

        return [s, signifier].compactMap{$0}.joined(separator: "")
    }
}

extension String {
    public func padded(to count: Int, onRight: Bool = false, with character: Character = " ") -> String {
        let startCount = self.count
        let padCount = count - startCount
        guard padCount > 0 else { return self }
        let pad = String(repeating: String(character), count: padCount)
        return onRight ? (self + pad) : (pad + self)
    }

    public static func padded(to count: Int, onRight: Bool = false, with character: Character = " ") -> (String) -> String {
        return { $0.padded(to: count, onRight: onRight, with: character) }
    }

    public func paddedWithZeros(to count: Int) -> String {
        return padded(to: count, onRight: false, with: "0")
    }

    public static func paddedWithZeros(to count: Int) -> (String) -> String {
        return { $0.paddedWithZeros(to: count) }
    }
}

extension String {
    public func nilIfEmpty() -> String? {
        return isEmpty ? nil : self
    }

    public static func emptyIfNil(_ string: String?) -> String {
        return string ?? ""
    }
}

extension String {
    public func split(by size: Int) -> [String] {
        var parts = [String]()
        var start = startIndex
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            parts.append(String(self[start ..< end]))
            start = end
        }
        return parts
    }

    public func capitalizedFirstCharacter() -> String {
        let first = String(self.first!).capitalized
        let rest = self.dropFirst()
        return first + rest
    }

    public func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public func indented(_ level: Int = 1, with indentationMark: String = .tab, lineSeparator: String = .newline) -> String {
        let indentation = String(repeating: indentationMark, count: level)
        let newlineIndentation = lineSeparator + indentation
        let lines = components(separatedBy: lineSeparator)
        let indentedLines = lines.joined(separator: newlineIndentation)
        return indentation + indentedLines
    }
}
