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

    func testDay06() throws {
        let day = Day06()
        XCTAssertEqual(try day.part1(), 2612736)
        XCTAssertEqual(try day.part2(), 29891250)
    }

    func testDay07() throws {
        let day = Day07()
        XCTAssertEqual(try day.part1(), 250602641)
        XCTAssertEqual(try day.part2(), 251037509)
    }

    func testDay08() throws {
        let day = Day08()
        XCTAssertEqual(try day.part1(), 16897)
        XCTAssertEqual(try day.part2(), 16563603485021)
    }

    func testDay09() throws {
        let day = Day09()
        XCTAssertEqual(try day.part1(), 1992273652)
        XCTAssertEqual(try day.part2(), 1012)
    }

    func testDay10() throws {
        let day = Day10()
        XCTAssertEqual(try day.part1(), 6717)
        XCTAssertEqual(try day.part2(), 381)
    }

    func testDay11() throws {
        let day = Day11()
        XCTAssertEqual(try day.part1(), 9974721)
        XCTAssertEqual(try day.part2(), 702770569197)
    }
}
