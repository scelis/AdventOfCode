import Foundation
import XCTest
@testable import AOC2023

class AOC2023Tests: XCTestCase {
    func testDay01() throws {
        let day = Day01()
        XCTAssertEqual(try day.part1(), 54951)
        XCTAssertEqual(try day.part2(), 55218)
    }

    func testDay02() throws {
        let day = Day02()
        XCTAssertEqual(try day.part1(), 1931)
        XCTAssertEqual(try day.part2(), 83105)
    }
}
