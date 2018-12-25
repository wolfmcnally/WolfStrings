//
//  AttributedSubstring.swift
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

public class AttributedSubstring {
    public let attrString: AttributedString
    public let strRange: StringRange
    public let nsRange: NSRange

    public init(string attrString: AttributedString, range strRange: StringRange? = nil) {
        self.attrString = attrString
        self.strRange = strRange ?? attrString.string.stringRange
        self.nsRange = attrString.string.nsRange(from: self.strRange)!
    }

    public convenience init(string attrString: AttributedString, fromIndex index: StringIndex) {
        self.init(string: attrString, range: index..<attrString.string.endIndex)
    }

    public convenience init(string attrString: AttributedString) {
        self.init(string: attrString, range: attrString.string.startIndex..<attrString.string.endIndex)
    }

    public var count: Int {
        return attrString.string.distance(from: strRange.lowerBound, to: strRange.upperBound)
    }

    public var attributedSubstring: AttributedString {
        return attrString.attributedSubstring(from: strRange)
    }

    public func attributes(in rangeLimit: StringRange? = nil) -> StringAttributes {
        return attrString.attributes(at: strRange.lowerBound, in: rangeLimit)
    }

    public func attributesWithLongestEffectiveRange(in rangeLimit: StringRange? = nil) -> (attributes: StringAttributes, longestEffectiveRange: StringRange) {
        return attrString.attributesWithLongestEffectiveRange(at: strRange.lowerBound, in: rangeLimit)
    }

    public func attribute(_ name: NSAttributedString.Key, in rangeLimit: StringRange? = nil) -> Any? {
        return attrString.attribute(name, at: strRange.lowerBound, in: rangeLimit)
    }

    public func attributeWithLongestEffectiveRange(_ name: NSAttributedString.Key, in rangeLimit: StringRange? = nil) -> (attribute: Any?, longestEffectiveRange: StringRange) {
        return attrString.attributeWithLongestEffectiveRange(name, at: strRange.lowerBound, in: rangeLimit)
    }

    public func enumerateAttributes(options opts: NSAttributedString.EnumerationOptions = [], using block: (StringAttributes, StringRange, AttributedSubstring) -> Bool) {
        attrString.enumerateAttributes(in: strRange, options: opts, using: block)
    }

    public func enumerateAttribute(_ name: NSAttributedString.Key, options opts: NSAttributedString.EnumerationOptions = [], using block: (Any?, StringRange, AttributedSubstring) -> Bool) {
        attrString.enumerateAttribute(name, in: strRange, options: opts, using: block)
    }

    public func setAttributes(_ attrs: StringAttributes?) {
        attrString.setAttributes(attrs, range: strRange)
    }

    public func addAttribute(_ name: NSAttributedString.Key, value: Any) {
        attrString.addAttribute(name, value: value, range: strRange)
    }

    public func addAttributes(_ attrs: StringAttributes) {
        attrString.addAttributes(attrs, range: strRange)
    }

    public func removeAttribute(_ name: NSAttributedString.Key) {
        attrString.removeAttribute(name, range: strRange)
    }
}

extension AttributedSubstring: CustomStringConvertible {
    public var description: String {
        let s = attrString.string[strRange]
        return "(AttributedSubstring attrString:\(s), strRange:\(strRange))"
    }
}

extension AttributedSubstring {
    public func addTag(_ tag: NSAttributedString.Key) {
        self[tag] = true
    }

    public func getRange(forTag tag: NSAttributedString.Key) -> StringRange? {
        let (value, longestEffectiveRange) = attributeWithLongestEffectiveRange(tag)
        if value is Bool {
            return longestEffectiveRange
        } else {
            return nil
        }
    }

    public func getString(forTag tag: NSAttributedString.Key) -> String? {
        if let range = getRange(forTag: tag) {
            return String(attrString.string[range])
        } else {
            return nil
        }
    }

    public func hasTag(_ tag: NSAttributedString.Key) -> Bool {
        return getRange(forTag: tag) != nil
    }

    public subscript(name: NSAttributedString.Key) -> Any? {
        get {
            return attribute(name)
        }
        set {
            if let newValue = newValue {
                addAttribute(name, value: newValue)
            } else {
                removeAttribute(name)
            }
        }
    }

    public var tag: NSAttributedString.Key {
        get { fatalError("Unimplemented.") }
        set { addTag(newValue) }
    }
}
