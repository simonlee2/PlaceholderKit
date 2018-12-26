import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ImagesExample_macOSTests.allTests),
    ]
}
#endif