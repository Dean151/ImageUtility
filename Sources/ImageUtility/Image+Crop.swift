/*
 * Image+Crop.swift
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
    
    /// Defines the image position when cropping it.
    public enum CroppingPosition {
        /// Keep the top left corner in place
        case topLeft
        
        /// Keep the top while centering horizontally.
        case top
        
        /// Keep the top right corner in place
        case topRight
        
        /// Keep the left while centering vertically
        case left
        
        /// Keep the center, centering horizontally and vertically
        case center
        
        /// Keep the right while centering vertically
        case right
        
        /// Keep the bottom left corner in place
        case bottomLeft
        
        /// Keep the bottom while centering horizontally
        case bottom
        
        /// Keep the bottom right corner in place
        case bottomRight
    }
    
    /**
     Create a new *UIImage* instance cropped by the given insets
     
     - Parameter size: The new size for the image. If the given size is greater than the image, no crop will happen in that direction.
     
     - Parameter position: How the image will be positionned regarding the crop process.
     
     - Returns: A new *UIImage* instance, cropped
     */
    public func cropping(to size: CGSize, position: CroppingPosition = .center) throws -> UIImage {
        let top, left, bottom, right: CGFloat
        
        switch position {
        case .topLeft, .top, .topRight:
            top = 0
            bottom = max(0, self.size.height - size.height)
        case .left, .center, .right:
            let amount = max(0, (self.size.height - size.height) / 2)
            top = amount
            bottom = amount
        case .bottomLeft, .bottom, .bottomRight:
            top = max(0, self.size.height - size.height)
            bottom = 0
        }
        
        switch position {
        case .topLeft, .left, .bottomLeft:
            left = 0
            right = max(0, self.size.width - size.width)
        case .top, .center, .bottom:
            let amount = max(0, (self.size.width - size.width) / 2)
            left = amount
            right = amount
        case .topRight, .right, .bottomRight:
            left = max(0, self.size.width - size.width)
            right = 0
        }
        
        let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return try cropping(by: insets)
    }
    
    /**
     Create a new *UIImage* instance cropped by the given insets
     
     - Parameter edgeInsets: The insets to crop from the image
     
     - Returns: A new *UIImage* instance, cropped
     */
    public func cropping(by edgeInsets: UIEdgeInsets) throws -> UIImage {
        var rect = CGRect(origin: .zero, size: CGSize(width: self.size.width * self.scale, height: self.size.height * self.scale))
        rect.origin.x += edgeInsets.left * self.scale
        rect.origin.y += edgeInsets.top * self.scale
        rect.size.width -= (edgeInsets.left + edgeInsets.right) * self.scale
        rect.size.height -= (edgeInsets.top + edgeInsets.bottom) * self.scale
        return try cropping(to: rect)
    }
    
    /**
     Create a new *UIImage* instance cropped to the given rect
     
     - Parameter rect: The rect to crop the image in

     - Returns: A new *UIImage* instance, cropped
     */
    public func cropping(to rect: CGRect) throws -> UIImage {
        guard let cgImage = self.cgImage?.cropping(to: rect) else {
            throw ImageUtilityErrors.noCgImage
        }
        return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
    }
}
