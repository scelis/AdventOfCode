import Foundation
import XCTest
@testable import AOC2020

class AOC2020Tests: XCTestCase {
    func testDay01() throws {
        let day = Day01()
        XCTAssertEqual(try day.part1(), 840324)
        XCTAssertEqual(try day.part2(), 170098110)
    }

    func testDay02() throws {
        let day = Day02()
        XCTAssertEqual(try day.part1(), 638)
        XCTAssertEqual(try day.part2(), 699)
    }

    func testDay03() throws {
        let day = Day03()
        XCTAssertEqual(try day.part1(), 198)
        XCTAssertEqual(try day.part2(), 5140884672)
    }

    func testDay04() throws {
        let day = Day04()
        XCTAssertEqual(try day.part1(), 202)
        XCTAssertEqual(try day.part2(), 137)
    }

    func testDay05() throws {
        let day = Day05()
        XCTAssertEqual(try day.part1(), 850)
        XCTAssertEqual(try day.part2(), 599)
    }

    func testDay06() throws {
        let day = Day06()
        XCTAssertEqual(try day.part1(), 6596)
        XCTAssertEqual(try day.part2(), 3219)
    }

    func testDay07() throws {
        let day = Day07()
        XCTAssertEqual(try day.part1(), 161)
        XCTAssertEqual(try day.part2(), 30899)
    }

    func testDay08() throws {
        let day = Day08()
        XCTAssertEqual(try day.part1(), 1337)
        XCTAssertEqual(try day.part2(), 1358)
    }

    func testDay09() throws {
        let day = Day09()
        XCTAssertEqual(try day.part1(), 26796446)
        XCTAssertEqual(try day.part2(), 3353494)
    }

    func testDay10() throws {
        let day = Day10()
        XCTAssertEqual(try day.part1(), 2100)
        XCTAssertEqual(try day.part2(), 16198260678656)
    }

    func testDay11() throws {
        let day = Day11()
        XCTAssertEqual(try day.part1(), 2483)
        XCTAssertEqual(try day.part2(), 2285)
    }

    func testDay12() throws {
        let day = Day12()
        XCTAssertEqual(try day.part1(), 636)
        XCTAssertEqual(try day.part2(), 26841)
    }

    func testDay13() throws {
        let day = Day13()
        XCTAssertEqual(try day.part1(), 153)
        XCTAssertEqual(try day.part2(), 471793476184394)
    }

    func testDay14() throws {
        let day = Day14()
        XCTAssertEqual(try day.part1(), 10050490168421)
        XCTAssertEqual(try day.part2(), 2173858456958)
    }

    func testDay15() throws {
        let day = Day15()
        XCTAssertEqual(try day.part1(), 614)
        XCTAssertEqual(try day.part2(), 1065)
    }

    func testDay16() throws {
        let day = Day16()
        XCTAssertEqual(try day.part1(), 25972)
        XCTAssertEqual(try day.part2(), 622670335901)
    }
}
