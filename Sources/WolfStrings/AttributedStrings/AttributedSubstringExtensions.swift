//
//  AttributedSubstringExtensions.swift
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
#if canImport(AppKit)
    import AppKit
#elseif canImport(UIKit)
    import UIKit
#endif

extension NSAttributedString.Key {
    public static let overrideTintColorTag = NSAttributedString.Key("overrideTintColorTag")
}

#if os(watchOS)
    extension NSAttributedString.Key {
        public static let font = NSAttributedString.Key("NSFont")
        public static let foregroundColor = NSAttributedString.Key("NSColor")
        public static let paragraphStyle = NSAttributedString.Key("NSParagraphStyle")
    }
#endif

extension AttributedSubstring {
    #if canImport(UIKit)
    public var font: UIFont {
        get {
            return attribute(.font) as? UIFont ?? UIFont.systemFont(ofSize: 12)
        }
        set { addAttribute(.font, value: newValue) }
    }

    public var foregroundColor: UIColor {
        get { return attribute(.foregroundColor) as? UIColor ?? .black }
        set { addAttribute(.foregroundColor, value: newValue) }
    }
    #elseif canImport(AppKit)
    public var font: NSFont {
        get {
            return attribute(.font) as? NSFont ?? NSFont.systemFont(ofSize: 12)
        }
        set { addAttribute(.font, value: newValue) }
    }

    public var foregroundColor: NSColor {
        get { return attribute(.foregroundColor) as? NSColor ?? .black }
        set { addAttribute(.foregroundColor, value: newValue) }
    }
    #endif

    public var paragraphStyle: NSMutableParagraphStyle {
        get {
            if let value = attribute(.paragraphStyle) as? NSParagraphStyle {
                return value.mutableCopy() as! NSMutableParagraphStyle
            } else {
                return NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            }
        }
        set { addAttribute(.paragraphStyle, value: newValue) }
    }

    public var textAlignment: NSTextAlignment {
        get {
            return self.paragraphStyle.alignment
        }
        set {
            let paragraphStyle = self.paragraphStyle
            paragraphStyle.alignment = newValue
            self.paragraphStyle = paragraphStyle
        }
    }

    public var overrideTintColor: Bool {
        get { return hasTag(.overrideTintColorTag) }
        set {
            if newValue {
                addTag(.overrideTintColorTag)
            } else {
                removeAttribute(.overrideTintColorTag)
            }
        }
    }
}
#endif
