/*
 * ImageUtilityTests.swift
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

class ImageColorTests: XCTestCase {

    func testFilledWithSizeImage() {
        let size = CGSize(width: 100, height: 100)
        let image = UIImage(filledWith: .white, of: size)
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.size, size)
        XCTAssertEqual(image?.scale, 1)
    }
    
    func testFilledWithSizeImagePerformance() {
        let size = CGSize(width: 1000, height: 1000)
        self.measure {
            _ = UIImage(filledWith: .blue, of: size)
        }
    }
    
    func testAverageImageColor() {
        let size = CGSize(width: 100, height: 100)
        let color = UIColor.blue
        let image = UIImage(filledWith: color, of: size)
        XCTAssertEqual(image?.averageColor, color)
    }
    
    func testAverageImageColorPerformance() {
        let size = CGSize(width: 1000, height: 1000)
        let color = UIColor.blue
        let image = UIImage(filledWith: color, of: size)
        self.measure {
            _ = image?.averageColor
        }
    }

}
