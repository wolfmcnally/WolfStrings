//
//  TypeLine.swift
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

import CoreText

public class TypeLine {
    private let ctLine: CTLine

    public private(set) lazy var trailingWhitespaceWidth = CGFloat(CTLineGetTrailingWhitespaceWidth(ctLine))

    public private(set) lazy var typeBounds: TypeBounds = {
        var ascent: CGFloat = 0, descent: CGFloat = 0, leading: CGFloat = 0
        let width = CGFloat(CTLineGetTypographicBounds(ctLine, &ascent, &descent, &leading)) - trailingWhitespaceWidth
        let height = ascent + descent + leading
        return TypeBounds(width: width, ascent: ascent, descent: descent, leading: leading, height: height)
    }()

    public var width: CGFloat { return typeBounds.width }
    public var ascent: CGFloat { return typeBounds.ascent }
    public var descent: CGFloat { return typeBounds.descent }
    public var leading: CGFloat { return typeBounds.leading }
    public var height: CGFloat { return typeBounds.height }

    public init(ctLine: CTLine) {
        self.ctLine = ctLine
    }

    public private(set) lazy var runs: [TypeRun] = {
        let r = CTLineGetGlyphRuns(ctLine) as! [CTRun]
        return r.map { TypeRun(ctRun: $0) }
    }()

    public private(set) lazy var glyphCount: Int = CTLineGetGlyphCount(ctLine)
}

extension TypeLine: CustomStringConvertible {
    public var description: String {
        return "(TypeLine width: \(width), ascent: \(ascent), descent: \(descent), leading \(leading))"
    }
}
