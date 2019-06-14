//
//  OSFont.swift
//  WolfStrings
//
//  Created by Wolf McNally on 6/22/17.
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

#if canImport(AppKit)
import AppKit
public typealias OSFont = NSFont
public typealias OSFontDescriptor = NSFontDescriptor
public typealias OSFontDescriptorSymbolicTraits = NSFontDescriptor.SymbolicTraits
extension NSFont {
    public static var familyNames: [String] {
        return NSFontManager.shared.availableFontFamilies
    }
    public static func fontNames(forFamilyName family: String) -> [String] {
        guard let members = NSFontManager.shared.availableMembers(ofFontFamily: family) else { return [] }
        return members.map { $0[0] as! String }
    }
}
#elseif canImport(UIKit)
import UIKit
public typealias OSFont = UIFont
public typealias OSFontDescriptor = UIFontDescriptor
public typealias OSFontDescriptorSymbolicTraits = UIFontDescriptor.SymbolicTraits
#endif

#if !os(Linux)
extension OSFontDescriptorSymbolicTraits {
    public mutating func insertBold() {
        #if os(macOS)
        insert(.bold)
        #else
        insert(.traitBold)
        #endif
    }

    public mutating func insertItalic() {
        #if os(macOS)
        insert(.italic)
        #else
        insert(.traitItalic)
        #endif
    }
}

extension OSFontDescriptor {
    public func makeWithSymbolicTraits(_ traits: OSFontDescriptorSymbolicTraits) -> OSFontDescriptor {
        #if os(macOS)
        return withSymbolicTraits(traits)
        #else
        return withSymbolicTraits(traits)!
        #endif
    }
}

extension OSFont {
    public static func makeWithDescriptor(_ descriptor: OSFontDescriptor, size: CGFloat = 0) -> OSFont {
        #if os(macOS)
        return NSFont(descriptor: descriptor, size: size)!
        #else
        return UIFont(descriptor: descriptor, size: size)
        #endif
    }
}
#endif
