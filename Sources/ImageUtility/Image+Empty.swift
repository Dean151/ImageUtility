/*
 * Image+Empty.swift
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

import UIKit

extension UIImage {

    /// Is true if the image only contains fully transparent pixels. False otherwise
    public var isEmpty: Bool {
        guard let cgImage = self.cgImage else {
            return true
        }

        let width = cgImage.width
        let height = cgImage.height
        let bitsPerComponent = MemoryLayout<UInt8>.size * 8
        let bytesPerRow = width * MemoryLayout<UInt8>.size

        // Allocate array to hold alpha channel
        var bitmap = [UInt8](repeating: 0, count: width * height)

        //Get a bitmap context for the image
        guard let context = CGContext(data: &bitmap, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue) else {
            return true
        }

        context.interpolationQuality = .low

        // Draw our image on that context
        let rect = CGRect(x: 0, y: 0, width: width, height: height).integral
        context.draw(cgImage, in: rect)

        for row in 0..<height {
            for col in 0..<width {
                if bitmap[row * bytesPerRow + col] > 0 {
                    return false
                }
            }
        }

        return true
    }
}
