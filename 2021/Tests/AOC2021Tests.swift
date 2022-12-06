import Foundation
import XCTest
@testable import AOC2021

class AOC2021Tests: XCTestCase {
    func testDay01() throws {
        let day = Day01()
        XCTAssertEqual(try day.part1(), 1446)
        XCTAssertEqual(try day.part2(), 1486)
    }

    func testDay02() throws {
        let day = Day02()
        XCTAssertEqual(try day.part1(), 1250395)
        XCTAssertEqual(try day.part2(), 1451210346)
    }

    func testDay03() throws {
        let day = Day03()
        XCTAssertEqual(try day.part1(), 2583164)
        XCTAssertEqual(try day.part2(), 2784375)
    }

    func testDay04() throws {
        let day = Day04()
        XCTAssertEqual(try day.part1(), 34506)
        XCTAssertEqual(try day.part2(), 7686)
    }

    func testDay05() throws {
        let day = Day05()
        XCTAssertEqual(try day.part1(), 6225)
        XCTAssertEqual(try day.part2(), 22116)
    }

    func testDay06() throws {
        let day = Day06()
        XCTAssertEqual(try day.part1(), 380758)
        XCTAssertEqual(try day.part2(), 1710623015163)
    }

    func testDay07() throws {
        let day = Day07()
        XCTAssertEqual(try day.part1(), 331067)
        XCTAssertEqual(try day.part2(), 92881128)
    }

    func testDay08() throws {
        let day = Day08()
        XCTAssertEqual(try day.part1(), 512)
        XCTAssertEqual(try day.part2(), 1091165)
    }
}
