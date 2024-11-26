import Foundation
import XCTest
@testable import AdventKit2

class Coordinate2DTests: XCTestCase {
    func testStepToward() {
        XCTAssertEqual(
            Coordinate2D(x: 5, y: 2).step(toward: Coordinate2D(x: 10, y: -5)),
            Coordinate2D(x: 6, y: 1)
        )
    }
}
