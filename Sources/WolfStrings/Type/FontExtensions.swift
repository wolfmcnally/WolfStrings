//
//  FontExtensions.swift
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
#elseif canImport(UIKit)
import UIKit
#endif

#if os(macOS)
extension NSFont {
    public var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.bold)
    }

    public var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.italic)
    }

    public var plainVariant: NSFont {
        return NSFont(descriptor: fontDescriptor.withSymbolicTraits([]), size: 0)!
    }

    public var boldVariant: NSFont {
        return NSFont(descriptor: fontDescriptor.withSymbolicTraits([.bold]), size: 0)!
    }

    public var italicVariant: NSFont {
        return NSFont(descriptor: fontDescriptor.withSymbolicTraits([.italic]), size: 0)!
    }
}

public func withPointSize(_ pointSize: CGFloat) -> (_ font: NSFont) -> NSFont {
    return { font in
        return NSFont(descriptor: font.fontDescriptor, size: pointSize)!
    }
}

public func withBold(_ font: NSFont) -> NSFont {
    return NSFont(descriptor: font.fontDescriptor.withSymbolicTraits([.bold]), size: 0) ?? font
}

public func withItalic(_ font: NSFont) -> NSFont {
    return NSFont(descriptor: font.fontDescriptor.withSymbolicTraits([.italic]), size: 0) ?? font
}
#else
extension UIFont {
    public var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    public var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

    public var plainVariant: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits([])!, size: 0)
    }

    public var boldVariant: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits([.traitBold])!, size: 0)
    }

    public var italicVariant: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits([.traitItalic])!, size: 0)
    }
}

public func withPointSize(_ pointSize: CGFloat) -> (_ font: UIFont) -> UIFont {
    return { font in
        return font.withSize(pointSize)
    }
}

public func withBold(_ font: UIFont) -> UIFont {
    guard let descriptor = font.fontDescriptor.withSymbolicTraits([.traitBold]) else {
        return font
    }
    return UIFont(descriptor: descriptor, size: 0)
}

public func withItalic(_ font: UIFont) -> UIFont {
    guard let descriptor = font.fontDescriptor.withSymbolicTraits([.traitItalic]) else {
        return font
    }
    return UIFont(descriptor: descriptor, size: 0)
}
#endif
