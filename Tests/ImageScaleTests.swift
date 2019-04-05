/*
 * ImageScaleTests.swift
 * Created by Thomas DURAND
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

class ImageScaleTests: XCTestCase {
    
    func testScaleToImage() {
        let size = CGSize(width: 1000, height: 1000)
        let newSize = CGSize(width: 50, height: 100)
        let image = UIImage(filledWith: .white, of: size)
        let scaled = image?.scaled(to: newSize)
        XCTAssertEqual(scaled?.size, newSize)
        XCTAssertEqual(scaled?.scale, image?.scale)
    }
    
    func testScaleByImage() {
        let size = CGSize(width: 1000, height: 100)
        let image = UIImage(filledWith: .white, of: size)
        let scaled = image?.scaled(by: 3.5)
        XCTAssertEqual(scaled?.size, CGSize(width: 3500, height: 350))
        let scaled2 = image?.scaled(by: 0.2)
        XCTAssertEqual(scaled2?.size, CGSize(width: 200, height: 20))
    }
    
    func testScaleByInvalidMultiplier() {
        let size = CGSize(width: 1000, height: 100)
        let image = UIImage(filledWith: .white, of: size)
        XCTAssertNil(image?.scaled(by: 0))
        XCTAssertNil(image?.scaled(by: -3))
        XCTAssertNotNil(image?.scaled(by: 1))
    }
    
    func testScaleToFitImage() {
        let size = CGSize(width: 1234, height: 1234)
        let image = UIImage(filledWith: .white, of: size)
        let fit = CGSize(width: 100, height: 150)
        let scaled = image?.scaledToFit(in: fit)
        XCTAssertEqual(scaled?.size, CGSize(width: 100, height: 100))
    }
    
    func testScaleToFillImage() {
        let size = CGSize(width: 1234, height: 1234)
        let image = UIImage(filledWith: .white, of: size)
        let fill = CGSize(width: 200, height: 300)
        let scaled = image?.scaledToFill(in: fill)
        XCTAssertEqual(scaled?.size, CGSize(width: 300, height: 300))
    }
    
    func testScaleToImagePerformance() {
        let size = CGSize(width: 1000, height: 1000)
        let newSize = CGSize(width: 50, height: 100)
        let image = UIImage(filledWith: .white, of: size)
        self.measure {
            _ = image?.scaled(to: newSize)
        }
    }
}
