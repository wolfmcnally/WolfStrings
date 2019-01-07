//
//  AttributedStringExtensions.swift
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

#if canImport(AppKit)
    import AppKit
#elseif canImport(UIKit)
    import UIKit
#endif

extension AttributedString {
    public var count: Int {
        return string.count
    }

    public func attributedSubstring(from range: StringRange) -> AttributedString {
        return attributedSubstring(from: string.nsRange(from: range)!)§
    }

    public func attributes(at index: StringIndex, in rangeLimit: StringRange? = nil) -> StringAttributes {
        let nsLocation = string.nsLocation(fromIndex: index)
        let nsRangeLimit = string.nsRange(from: rangeLimit) ?? string.nsRange
        let attrs = attributes(at: nsLocation, longestEffectiveRange: nil, in: nsRangeLimit)
        return attrs
    }

    public func attributesWithLongestEffectiveRange(at index: StringIndex, in rangeLimit: StringRange? = nil) -> (attributes: StringAttributes, longestEffectiveRange: StringRange) {
        let nsLocation = string.nsLocation(fromIndex: index)
        let nsRangeLimit = string.nsRange(from: rangeLimit) ?? string.nsRange
        var nsRange = NSRange()
        let attrs = attributes(at: nsLocation, longestEffectiveRange: &nsRange, in: nsRangeLimit)
        let range = string.stringRange(from: nsRange)!
        return (attrs, range)
    }

    public func attribute(_ name: NSAttributedString.Key, at index: StringIndex, in rangeLimit: StringRange? = nil) -> Any? {
        guard !string.isEmpty else { return nil }
        let nsLocation = string.nsLocation(fromIndex: index)
        let nsRangeLimit = string.nsRange(from: rangeLimit) ?? string.nsRange
        let attr = attribute(name, at: nsLocation, longestEffectiveRange: nil, in: nsRangeLimit)
        return attr
    }

    public func attributeWithLongestEffectiveRange(_ name: NSAttributedString.Key, at index: StringIndex, in rangeLimit: StringRange? = nil) -> (attribute: Any?, longestEffectiveRange: StringRange) {
        let nsLocation = string.nsLocation(fromIndex: index)
        let nsRangeLimit = string.nsRange(from: rangeLimit) ?? string.nsRange
        var nsRange = NSRange()
        let attr = attribute(name, at: nsLocation, longestEffectiveRange: &nsRange, in: nsRangeLimit)
        let range = string.stringRange(from: nsRange)!
        return (attr, range)
    }

    public func enumerateAttributes(in enumerationRange: StringRange? = nil, options opts: NSAttributedString.EnumerationOptions = [], using block: (StringAttributes, StringRange, AttributedSubstring) -> Bool) {
        let nsRange = string.nsRange(from: enumerationRange) ?? string.nsRange
        enumerateAttributes(in: nsRange, options: opts) { (attrs, nsRange, stop) in
            let range = self.string.stringRange(from: nsRange)!
            stop[0] = ObjCBool(block(attrs, range, self.substring(in: range)))
        }
    }

    public func enumerateAttribute(_ name: NSAttributedString.Key, in enumerationRange: StringRange? = nil, options opts: NSAttributedString.EnumerationOptions = [], using block: (Any?, StringRange, AttributedSubstring) -> Bool) {
        let nsEnumerationRange = string.nsRange(from: enumerationRange) ?? string.nsRange
        enumerateAttribute(name, in: nsEnumerationRange, options: opts) { (value, nsRange, stop) in
            let range = self.string.stringRange(from: nsRange)!
            stop[0] = ObjCBool(block(value, range, self.substring(in: range)))
        }
    }

    public func replaceCharacters(in range: StringRange, with str: String) {
        let nsRange = string.nsRange(from: range)!
        replaceCharacters(in: nsRange, with: str)
    }

    public func setAttributes(_ attrs: StringAttributes?, range: StringRange? = nil) {
        let nsRange = string.nsRange(from: range) ?? string.nsRange
        setAttributes(attrs, range: nsRange)
    }

    public func addAttribute(_ name: NSAttributedString.Key, value: Any, range: StringRange? = nil) {
        let nsRange = string.nsRange(from: range) ?? string.nsRange
        addAttribute(name, value: value, range: nsRange)
    }

    public func addAttributes(_ attrs: StringAttributes, range: StringRange? = nil) {
        let nsRange = string.nsRange(from: range) ?? string.nsRange
        addAttributes(attrs, range: nsRange)
    }

    public func removeAttribute(_ name: NSAttributedString.Key, range: StringRange? = nil) {
        let nsRange = string.nsRange(from: range) ?? string.nsRange
        removeAttribute(name, range: nsRange)
    }

    public func replaceCharacters(in range: StringRange, with attrString: AttributedString) {
        let nsRange = string.nsRange(from: range)!
        replaceCharacters(in: nsRange, with: attrString)
    }

    public func insert(_ attrString: AttributedString, at index: StringIndex) {
        let nsLocation = string.nsLocation(fromIndex: index)
        insert(attrString, at: nsLocation)
    }

    public func deleteCharacters(in range: StringRange) {
        let nsRange = string.nsRange(from: range)!
        deleteCharacters(in: nsRange)
    }
}

extension AttributedString {
    public func substring(in range: StringRange? = nil) -> AttributedSubstring {
        return AttributedSubstring(string: self, range: range)
    }

    public func substring(from index: StringIndex) -> AttributedSubstring {
        return AttributedSubstring(string: self, fromIndex: index)
    }

    public func substrings(withTag tag: NSAttributedString.Key) -> [AttributedSubstring] {
        var result = [AttributedSubstring]()

        var index = string.startIndex
        while index < string.endIndex {
            let (attrs, longestEffectiveRange) = attributesWithLongestEffectiveRange(at: index)
            if attrs[tag] as? Bool == true {
                let substring = AttributedSubstring(string: self, range: longestEffectiveRange)
                result.append(substring)
                index = longestEffectiveRange.upperBound
            }
            index = string.index(index, offsetBy: 1)
        }

        return result
    }
}

extension AttributedString {
    public var tag: NSAttributedString.Key {
        get { return substring().tag }
        set { substring().tag = newValue }
    }

    public subscript(attribute: NSAttributedString.Key) -> Any? {
        get { return substring()[attribute] }
        set { substring()[attribute] = newValue! }
    }

    public func getString(forTag tag: NSAttributedString.Key, atIndex index: StringIndex) -> String? {
        return substring(from: index).getString(forTag: tag)
    }

    public func has(tag: NSAttributedString.Key, atIndex index: StringIndex) -> Bool {
        return substring(from: index).hasTag(tag)
    }

    public func edit(f: (AttributedSubstring) -> Void) {
        beginEditing()
        f(substring())
        endEditing()
    }

    public func edit(in range: StringRange, f: (AttributedSubstring) -> Void) {
        beginEditing()
        f(substring(in: range))
        endEditing()
    }
}

extension AttributedString {
    public func printAttributes() {
        let aliaser = ObjectAliaser()
        var strIndex = string.startIndex
        for char in string {
            let joiner = Joiner()
            joiner.append(char)
            let attrs: StringAttributes = attributes(at: strIndex)
            for(name, value) in attrs {
                let v = value as AnyObject
                joiner.append("\(name):\(aliaser.name(for: v))")
            }
            print(joiner)
            strIndex = string.index(strIndex, offsetBy: 1)
        }
    }
}

#if !os(Linux)

extension NSAttributedString {
    @available(macOS 10.11, *)
    public func height(forWidth width: CGFloat, context: NSStringDrawingContext? = nil) -> CGFloat {
        let maxBounds = CGSize(width: width, height: .greatestFiniteMagnitude)
        let bounds = boundingRect(with: maxBounds, options: [.usesLineFragmentOrigin], context: context)
        return ceil(bounds.height)
    }

    @available(macOS 10.11, *)
    public func width(forHeight height: CGFloat, context: NSStringDrawingContext? = nil) -> CGFloat {
        let maxBounds = CGSize(width: .greatestFiniteMagnitude, height: height)
        let bounds = boundingRect(with: maxBounds, options: [.usesLineFragmentOrigin], context: context)
        return ceil(bounds.width)
    }
}

extension AttributedString {
    #if canImport(UIKit)
    public var font: UIFont {
        get { return substring().font }
        set { substring().font = newValue }
    }

    public var foregroundColor: UIColor {
        get { return substring().foregroundColor }
        set { substring().foregroundColor = newValue }
    }
    #elseif canImport(AppKit)
    public var font: NSFont {
        get { return substring().font }
        set { substring().font = newValue }
    }

    public var foregroundColor: NSColor {
        get { return substring().foregroundColor }
        set { substring().foregroundColor = newValue }
    }
    #endif

    public var paragraphStyle: NSMutableParagraphStyle {
        get { return substring().paragraphStyle }
        set { substring().paragraphStyle = newValue }
    }

    public var textAlignment: NSTextAlignment {
        get { return substring().textAlignment }
        set { substring().textAlignment = newValue }
    }
}

#endif
