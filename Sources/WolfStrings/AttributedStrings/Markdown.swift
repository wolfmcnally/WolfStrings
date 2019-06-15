//
//  Markdown.swift
//  WolfCore
//
//  Created by Wolf McNally on 3/29/18.
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
import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

//        let text = """
//    Emphasis, aka italics, with *single asterisks* or _single underscores_.
//
//    Strong emphasis, aka bold, with **double asterisks** or __double underscores__.
//
//    Combined emphasis with **bold with double asterisks and _bold-italic with single underscores_**.
//
//    Strikethrough uses two tildes. ~~**Scratch** this.~~
//    """

extension NSAttributedString.Key {
    static let markdownBold = NSAttributedString.Key(rawValue: "markdownBold")
    static let markdownItalic = NSAttributedString.Key(rawValue: "markdownItalic")
    static let markdownStrikethrough = NSAttributedString.Key(rawValue: "markdownStrikethrough")
}

// Text surrounded by **double asterisks** or __double underscores__.
// (?:\*\*|__)(.*?)(?:\*\*|__)
private let boldRegex = try! NSRegularExpression(pattern: "(?:\\*\\*|__)(.*?)(?:\\*\\*|__)", options: [.dotMatchesLineSeparators])

// Text surrounded by *single asterisks* or _single underscores_.
// (?:\*|_)(.*?)(?:\*|_)
private let italicRegex = try! NSRegularExpression(pattern: "(?:\\*|_)(.*?)(?:\\*|_)", options: [.dotMatchesLineSeparators])

// Text surrounded by ~~double tildes~~.
// ~~(.*?)~~
private let strikethroughRegex = try! NSRegularExpression(pattern: "~~(.*?)~~", options: [.dotMatchesLineSeparators])

public func markdown(_ attrString: AttributedString?) -> AttributedString? {
    guard let attrString = attrString else { return nil }

    func replaceMatches(for regex: NSRegularExpression, adding attribute: NSAttributedString.Key) {
        let matches = regex.matches(in: attrString.string, options: [], range: attrString.string.nsRange)

        let attributes: StringAttributes = [
            attribute: true
        ]

        for match in matches.reversed() {
            let replaceRange = match.stringRange(at: 0, in: attrString.string)
            let captureRange = match.stringRange(at: 1, in: attrString.string)
            let capturedString = attrString.attributedSubstring(from: captureRange)
            capturedString.addAttributes(attributes)
            attrString.replaceCharacters(in: replaceRange, with: capturedString)
        }
    }

    replaceMatches(for: boldRegex, adding: .markdownBold)
    replaceMatches(for: italicRegex, adding: .markdownItalic)
    replaceMatches(for: strikethroughRegex, adding: .markdownStrikethrough)

    attrString.enumerateAttributes { (attributes, range, substring) -> Bool in
        var traits = OSFontDescriptorSymbolicTraits()
        if attributes[.markdownBold] != nil {
            traits.insertBold()
            substring.removeAttribute(.markdownBold)
        }
        if attributes[.markdownItalic] != nil {
            traits.insertItalic()
            substring.removeAttribute(.markdownItalic)
        }
        if attributes[.markdownStrikethrough] != nil {
            substring.removeAttribute(.markdownStrikethrough)
            substring.addAttributes([
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
                ])
        }
        let font = (attributes[.font] as? OSFont) ?? OSFont.systemFont(ofSize: 12)
        let descriptor = font.fontDescriptor.makeWithSymbolicTraits(traits)
        let newFont = OSFont.makeWithDescriptor(descriptor)
        substring.font = newFont

        return false
    }

    return attrString
}
#endif
