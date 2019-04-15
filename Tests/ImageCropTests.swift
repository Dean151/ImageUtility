/*
 * ImageCropTests.swift
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

class ImageCropTests: XCTestCase {
    
    func testCropImageToSize() {
        let size = CGSize(width: 1000, height: 1000)
        let newSize = CGSize(width: 50, height: 100)
        let image = try! UIImage(filledWith: .white, of: size)
        let cropped = try! image.cropping(to: newSize)
        XCTAssertEqual(cropped.size, newSize)
        XCTAssertEqual(cropped.scale, image.scale)
    }
    
    func testCropImageByInsets() {
        let size = CGSize(width: 1000, height: 600)
        let insets = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        let image = try! UIImage(filledWith: .white, of: size)
        let cropped = try! image.cropping(by: insets)
        XCTAssertEqual(cropped.size, CGSize(width: 800, height: 400))
        XCTAssertEqual(cropped.scale, image.scale)
    }
    
    func testCropImagePerformance() {
        let size = CGSize(width: 1000, height: 1000)
        let rect = CGRect(x: 450, y: 450, width: 100, height: 100)
        let image = try! UIImage(filledWith: .white, of: size)
        self.measure {
            _ = try! image.cropping(to: rect)
        }
    }
}
