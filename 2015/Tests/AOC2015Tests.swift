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

    func testDay04() throws {
        let day = Day04()
        XCTAssertEqual(try day.part1(), 282749)
        XCTAssertEqual(try day.part2(), 9962624)
    }

    func testDay05() throws {
        let day = Day05()
        XCTAssertEqual(try day.part1(), 236)
        XCTAssertEqual(try day.part2(), 51)
    }
}
