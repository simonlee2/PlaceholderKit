import XCTest
@testable import ImagesExample_macOS

final class ImagesExample_macOSTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ImagesExample_macOS().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
