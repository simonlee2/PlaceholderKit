//
//  PlaceholderFactoryTests.swift
//  PlaceholderKitTests
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

import XCTest
@testable import PlaceholderKit

class PlaceholderTests: XCTestCase {
    func testSolidColor() {
        // Given a valid setting
        let outputSize = CGSize(width: 1600, height: 900)
        let image = Placeholder(size: outputSize, backgroundStyle: .solidColor(.red)).render()

        // output should not be nil
        XCTAssertNotNil(image)

        // output should have the correct size
        XCTAssert(image!.size == outputSize, "Expected output to have size: \(outputSize), got \(image!.size)")
    }
}
