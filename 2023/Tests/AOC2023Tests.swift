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

    func testDay03() throws {
        let day = Day03()
        XCTAssertEqual(try day.part1(), 531561)
        XCTAssertEqual(try day.part2(), 83279367)
    }

    func testDay04() throws {
        let day = Day04()
        XCTAssertEqual(try day.part1(), 24175)
        XCTAssertEqual(try day.part2(), 18846301)
    }

    func testDay05() throws {
        let day = Day05()
        XCTAssertEqual(try day.part1(), 282277027)
        XCTAssertEqual(try day.part2(), 11554135)
    }
}
