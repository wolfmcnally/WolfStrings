//
//  Joiner.swift
//  WolfStrings
//
//  Created by Wolf McNally on 12/15/15.
//  Copyright © 2015 Wolf McNally
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

public class Joiner {
    var left: String
    var right: String
    var separator: String
    var objs = [Any]()
    var count: Int { return objs.count }
    public var isEmpty: Bool { return objs.isEmpty }

    public init(left: String = "", separator: String = " ", right: String = "") {
        self.left = left
        self.right = right
        self.separator = separator
    }

    public func append(_ objs: Any...) {
        self.objs.append(contentsOf: objs)
    }

    public func append<S: Sequence>(contentsOf newElements: S) {
        for element in newElements {
            objs.append(element)
        }
    }
}

extension Joiner: CustomStringConvertible {
    public var description: String {
        var s = [String]()
        for o in objs {
            s.append("\(o)")
        }
        let t = s.joined(separator: separator)
        return "\(left)\(t)\(right)"
    }
}
