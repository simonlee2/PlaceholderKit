//
//  PlaceholderFactoryTests.swift
//  PlaceholderKitTests
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

import XCTest
@testable import PlaceholderKit

class PlaceholderFactoryTests: XCTestCase {
    var factory: PlaceholderFactory?

    func testSolidColor() {
        // Given a valid setting
        let outputSize = CGSize(width: 1600, height: 900)
        let settings = PlaceholderSettings(size: outputSize,
                                           background: .solidColor(Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)),
                                           showDimensionAsText: true,
                                           convertDimensionToAspectRatio: true)

        factory = PlaceholderFactory(settings: settings)
        let placeholder = factory?.createPlaceholder()

        // output should not be nil
        XCTAssertNotNil(placeholder)

        // output should have the correct size
        XCTAssert(placeholder!.size == outputSize, "Expected output to have size: \(outputSize), got \(placeholder!.size)")
    }
}
