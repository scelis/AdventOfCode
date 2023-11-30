import Foundation
import XCTest
@testable import AOC2023

class AOC2023Tests: XCTestCase {
    func testDay01() throws {
        let day = Day01()
        XCTAssertEqual(try day.part1(), 0)
        XCTAssertEqual(try day.part2(), 0)
    }
}
