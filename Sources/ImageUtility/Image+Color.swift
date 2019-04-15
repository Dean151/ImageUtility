/*
 * Image+Color.swift
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
    
    /**
     Initializes and returns the image object at the given size and filled with the given color
     
     - Parameter color: The filled color
     
     - Parameter size: The target size for the initialized image
     
     - Returns: An initialized UIImage object, or nil if the method could not initialize the image.
    */
    public convenience init(filledWith color: UIColor, of size: CGSize) throws {
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let ctx = UIGraphicsGetCurrentContext() else {
            throw ImageUtilityErrors.noContext
        }
        ctx.setFillColor(color.cgColor)
        ctx.fill(CGRect(origin: CGPoint.zero, size: size))
        
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            throw ImageUtilityErrors.noContext
        }
        self.init(cgImage: cgImage)
    }
    
    /**
     Compute the average color of the image object
     
     - Returns: the average color of the image
    */
    public var averageColor: UIColor {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        let rect1x1 = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CGContext(data: &bitmap, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo)
        context?.draw(cgImage!, in: rect1x1)
        return UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
    }
}
