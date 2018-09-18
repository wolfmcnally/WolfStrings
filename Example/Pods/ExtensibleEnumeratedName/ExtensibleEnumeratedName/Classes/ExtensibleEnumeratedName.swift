//
//  ExtensibleEnumeratedName.swift
//  ExtensibleEnumeratedName
//
//  Created by Wolf McNally on 6/22/16.
//  Copyright © 2016 Wolf McNally
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

public protocol ExtensibleEnumeratedName: RawRepresentable, Hashable, Comparable, CustomStringConvertible {
    associatedtype ValueType: Hashable, Comparable
    var rawValue: ValueType { get }
}

extension ExtensibleEnumeratedName {
    // Hashable
    public var hashValue: Int { return rawValue.hashValue }

    // RawRepresentable
    // You must still provide this constructor:
    //public init?(rawValue: ValueType?)

    // CustomStringConvertible
    public var description: String {
        return String(describing: rawValue)
    }
}

public func < <T: ExtensibleEnumeratedName>(left: T, right: T) -> Bool {
    return left.rawValue < right.rawValue
}
