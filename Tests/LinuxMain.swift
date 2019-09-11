import XCTest

import ImageUtilityTests

var tests = [XCTestCaseEntry]()
tests += ImageColorTests.allTests()
tests += ImageCropTests.allTests()
tests += ImageEmptyTests.allTests()
tests += ImageScaleTests.allTests()
tests += ImageTrimTests.allTests()
XCTMain(tests)
