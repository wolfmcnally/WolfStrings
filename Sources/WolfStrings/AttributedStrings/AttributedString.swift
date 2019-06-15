//
//  AttributedString.swift
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

#if !os(Linux)
import WolfPipe
import WolfOSBridge
import Foundation
import CoreGraphics

public typealias AttributedString = NSMutableAttributedString
public typealias StringAttributes = [NSAttributedString.Key: Any]

public func += (left: AttributedString, right: NSAttributedString) {
    left.append(right)
}

public func withPointSize(_ pointSize: CGFloat) -> (_ string: AttributedString?) -> AttributedString? {
    return { string in
        guard let string = string else { return nil }
        string.font = string.font |> withPointSize(pointSize)
        return string
    }
}

public func withBold(_ string: AttributedString?) -> AttributedString? {
    guard let string = string else { return nil }
    string.font = string.font |> withBold
    return string
}

public func withItalic(_ string: AttributedString?) -> AttributedString? {
    guard let string = string else { return nil }
    string.font = string.font |> withItalic
    return string
}

public func withForegroundColor(_ color: OSColor) -> (_ string: AttributedString?) -> AttributedString? {
    return { string in
        guard let string = string else { return nil }
        string.foregroundColor = color
        return string
    }
}
#endif
