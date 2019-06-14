//
//  Typesetter.swift
//  WolfStrings
//
//  Created by Wolf McNally on 11/20/17.
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

#if canImport(CoreText)
import CoreText

public struct Typesetter {
    private let attrString: AttributedString
    private let typesetter: CTTypesetter

    private var string: String { return attrString.string }

    public init(attrString: AttributedString) {
        self.attrString = attrString
        typesetter = CTTypesetterCreateWithAttributedString(attrString)
    }

    public func createLine(for range: StringRange? = nil) -> TypeLine {
        let range = range ?? string.stringRange
        return TypeLine(ctLine: CTTypesetterCreateLine(typesetter, string.cfRange(from: range)!))
    }

    public func suggestLineBreak(startingAt startIndex: StringIndex, width: CGFloat) -> StringRange {
        let nsLocation = string.nsLocation(fromIndex: startIndex)
        let nsLength = CTTypesetterSuggestLineBreak(typesetter, nsLocation, Double(width))
        return string.stringRange(nsLocation: nsLocation, nsLength: nsLength)!
    }
}
#endif
