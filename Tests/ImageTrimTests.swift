/*
 * ImageTrimTests.swift
 * Created by Thomas DURAND
 *
 * MIT License
 *
 * Copyright (c) 2019 Thomas Durand
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import XCTest
@testable import ImageUtility

class ImageTrimTests: XCTestCase {
    
    func testTransparentInsets() {
        let insets = trimmableImage?.transparentInsets
        XCTAssertEqual(insets, UIEdgeInsets(top: 100, left: 200, bottom: 600, right: 350))
    }
    
    func testTrimmedImage() {
        let trimmed = trimmableImage?.trimmed()
        XCTAssertEqual(trimmed?.size, CGSize(width: 450, height: 300))
    }

    func testTrimImagePerformance() {
        self.measure {
            _ = trimmableImage?.trimmed()
        }
    }
    
    var trimmableImage: UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1000, height: 1000))
        defer {
            UIGraphicsEndImageContext()
        }
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        ctx.setFillColor(UIColor.blue.cgColor)
        ctx.fill(CGRect(x: 200, y: 100, width: 450, height: 300))
        
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
