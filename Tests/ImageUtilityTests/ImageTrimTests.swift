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
        let insets = try! trimmableImage.transparentInsets()
        XCTAssertEqual(insets, UIEdgeInsets(top: 100, left: 200, bottom: 1648, right: 2082))
    }

    func testTransparentInsetsWithScale() {
        let insets = try! trimmableImageWithScale.transparentInsets()
        XCTAssertEqual(insets, UIEdgeInsets(top: 272.5, left: 195.5, bottom: 219, right: 502))
    }
    
    func testTrimmedImage() {
        let trimmed = try! trimmableImage.trimmed()
        XCTAssertEqual(trimmed.size, CGSize(width: 450, height: 300))
    }

    func testTrimmedImageWithScale() {
        let trimmed = try! trimmableImageWithScale.trimmed()
        XCTAssertFalse(try! trimmed.isEmpty())
        XCTAssertEqual(trimmed.scale, 2)
        XCTAssertEqual(trimmed.size, CGSize(width: 396.5, height: 268.5))
    }

    func testTrimImagePerformance() {
        self.measure {
            _ = try! trimmableImage.trimmed()
        }
    }

    func testTrimImageWithScalePerformance() {
        self.measure {
            _ = try! trimmableImageWithScale.trimmed()
        }
    }
    
    var trimmableImage: UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 2732, height: 2048))
        defer {
            UIGraphicsEndImageContext()
        }
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(UIColor.blue.cgColor)
        ctx.fill(CGRect(x: 200, y: 100, width: 450, height: 300))
        let cgImage = UIGraphicsGetImageFromCurrentImageContext()!.cgImage!
        return UIImage(cgImage: cgImage)
    }

    var trimmableImageWithScale: UIImage {
        let imageUrl = Bundle(for: type(of: self)).url(forResource: "image", withExtension: "png")!
        let data = try! Data(contentsOf: imageUrl)
        return UIImage(data: data, scale: 2)!
    }

    static var allTests = [
        ("testTransparentInsets", testTransparentInsets),
        ("testTransparentInsetsWithScale", testTransparentInsetsWithScale),
        ("testTrimmedImage", testTrimmedImage),
        ("testTrimmedImageWithScale", testTrimmedImageWithScale),
        ("testTrimImagePerformance", testTrimImagePerformance),
        ("testTrimImageWithScalePerformance", testTrimImageWithScalePerformance),
    ]
}
