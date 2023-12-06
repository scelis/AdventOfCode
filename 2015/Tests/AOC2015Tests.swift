import Foundation
import XCTest
@testable import AOC2015

class AOC2015Tests: XCTestCase {
    func testDay01() throws {
        let day = Day01()
        XCTAssertEqual(try day.part1(), 138)
        XCTAssertEqual(try day.part2(), 1771)
    }

    func testDay02() throws {
        let day = Day02()
        XCTAssertEqual(try day.part1(), 1606483)
        XCTAssertEqual(try day.part2(), 3842356)
    }

    func testDay03() throws {
        let day = Day03()
        XCTAssertEqual(try day.part1(), 2081)
        XCTAssertEqual(try day.part2(), 2341)
    }
}
