//
//  Errors.swift
//  ImageUtility
//
//  Created by Thomas DURAND on 15/04/2019.
//  Copyright © 2019 Thomas DURAND. All rights reserved.
//

import Foundation

enum ImageUtilityErrors: Error {
    case noContext
    case noCgImage
    case noImageInCurrentContext
    case unvalidArgument
}
