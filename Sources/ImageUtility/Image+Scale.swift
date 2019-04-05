/*
 * Image+Scale.swift
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
     Create a new *UIImage* instance scaled at the specified size.
     UIImage original pixel scale is preserved.
     UIImage original ratio is not preserved.
     
     - Parameter size: The target size for the returned image
     
     - Returns: A new *UIImage* instance, at the specified size.
    */
    public func scaled(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /**
     Create a new *UIImage* instance scaled at a specific multiplier amount.
     UIImage original pixel scale & ratio are preserved.
     
     - Parameter multiplier: The amount you want the image's size multiplied by.
     
     - Returns: A new *UIImage* instance, with its size multiplied by a factor, preserving the ratio
     */
    public func scaled(by multiplier: CGFloat) -> UIImage? {
        guard multiplier > 0 else {
            return nil
        }
        guard multiplier != 1 else {
            return self.copy() as? UIImage
        }
        let newSize = CGSize(width: self.size.width * multiplier, height: self.size.height * multiplier)
        return scaled(to: newSize)
    }
    
    /**
     Create a new *UIImage* instance scaled to fit in a specific size.
     UIImage original pixel scale & ratio are preserved.
     
     - Parameter size: The target size for the image to fit in
     
     - Returns: A new *UIImage* instance, fitting in the given size, preserving the ratio
     */
    public func scaledToFit(in size: CGSize) -> UIImage? {
        let multiplier = min(size.width / self.size.width, size.height / self.size.height)
        return scaled(by: multiplier)
    }
    
    /**
     Create a new *UIImage* instance scaled to fill in a specific size.
     UIImage original pixel scale & ratio are preserved.
     
     - Parameter size: The target size for the image to fill in
     
     - Returns: A new *UIImage* instance, filling in the given size, preserving the ratio
     */
    public func scaledToFill(in size: CGSize) -> UIImage? {
        let multiplier = max(size.width / self.size.width, size.height / self.size.height)
        return scaled(by: multiplier)
    }
}
