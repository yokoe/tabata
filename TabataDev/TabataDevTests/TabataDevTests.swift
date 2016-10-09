//
//  TabataDevTests.swift
//  TabataDevTests
//
//  Created by Sota Yokoe on 2016/10/09.
//  Copyright © 2016年 Sota Yokoe. All rights reserved.
//

import XCTest
@testable import TabataDev

class TabataDevTests: XCTestCase {
    static let NumberOfFiltersToGenerate = 50
    func testPerformanceFilterInit() {
        let sourceImage = NSImage(named: "Kyoto")!
        
        self.measure {
            for _ in 0..<TabataDevTests.NumberOfFiltersToGenerate {
                autoreleasepool {
                    guard let filter = CIFilter(name: "CIExposureAdjust") else {
                        print("Failed to instantiate filter")
                        return
                    }
                    filter.setValue(1, forKey: "inputEV")
                    filter.setValue(sourceImage.ciImageObject!, forKey: kCIInputImageKey)
                    let _ = filter.outputImage!
                }
            }
        }
    }
    
    func testPerformanceFilterReuse() {
        let sourceImage = NSImage(named: "Kyoto")!
        
        self.measure {
            guard let filter = CIFilter(name: "CIExposureAdjust") else {
                print("Failed to instantiate filter")
                return
            }
            filter.setValue(1, forKey: "inputEV")
            for _ in 0..<TabataDevTests.NumberOfFiltersToGenerate {
                autoreleasepool {
                    filter.setValue(sourceImage.ciImageObject!, forKey: kCIInputImageKey)
                    let _ = filter.outputImage!
                }
            }
        }
    }
    
}

fileprivate extension NSImage {
    fileprivate var ciImageObject: CIImage? {
        if let tiffRep = tiffRepresentation, let bitmapImageRep = NSBitmapImageRep(data: tiffRep) {
            return CIImage(bitmapImageRep: bitmapImageRep)
        }
        return nil
    }
}
