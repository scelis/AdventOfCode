import Foundation
import XCTest
@testable import AOC2019

class AOC2019Tests: XCTestCase {
    func testDay01() throws {
        let day = Day01()
        XCTAssertEqual(try day.part1(), 3295206)
        XCTAssertEqual(try day.part2(), 4939939)
    }

    func testDay02() throws {
        let day = Day02()
        XCTAssertEqual(try day.part1(), 9706670)
        XCTAssertEqual(try day.part2(), 2552)
    }

    func testDay03() throws {
        let day = Day03()
        XCTAssertEqual(try day.part1(), 489)
        XCTAssertEqual(try day.part2(), 93654)
    }

    func testDay04() throws {
        let day = Day04()
        XCTAssertEqual(try day.part1(), 1748)
        XCTAssertEqual(try day.part2(), 1180)
    }

    func testDay05() throws {
        let day = Day05()
        XCTAssertEqual(try day.part1(), 7988899)
        XCTAssertEqual(try day.part2(), 13758663)
    }

    func testDay06() throws {
        let day = Day06()
        XCTAssertEqual(try day.part1(), 162439)
        XCTAssertEqual(try day.part2(), 367)
    }

    func testDay07() throws {
        let day = Day07()
        XCTAssertEqual(try day.part1(), 46248)
        XCTAssertEqual(try day.part2(), 54163586)
    }

    func testDay08() throws {
        let day = Day08()
        XCTAssertEqual(try day.part1(), 1703)
        XCTAssertTrue(try day.part2().contains("""
1001001100011001111011110
1001010010100101000010000
1111010000100001110011100
1001010000101101000010000
1001010010100101000010000
1001001100011101000011110
"""))
    }

    func testDay09() throws {
        let day = Day09()
        XCTAssertEqual(try day.part1(), 2204990589)
        XCTAssertEqual(try day.part2(), 50008)
    }

    func testDay10() throws {
        let day = Day10()
        XCTAssertEqual(try day.part1(), 326)
        XCTAssertEqual(try day.part2(), 1623)
    }

    func testDay11() throws {
        let day = Day11()
        XCTAssertEqual(try day.part1(), 2184)
        XCTAssertTrue(try day.part2().contains("""
⬛️⬛️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬛️
⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️
"""))
    }

    func testDay12() throws {
        let day = Day12()
        XCTAssertEqual(try day.part1(), 10055)
        XCTAssertEqual(try day.part2(), 374307970285176)
    }

    func testDay13() throws {
        let day = Day13()
        XCTAssertEqual(try day.part1(), 398)
        XCTAssertEqual(try day.part2(), 19447)
    }

    func testDay14() throws {
        let day = Day14()
        XCTAssertEqual(try day.part1(), 485720)
        XCTAssertEqual(try day.part2(), 3848998)
    }

    func testDay15() throws {
        let day = Day15()
        XCTAssertEqual(try day.part1(), 262)
        XCTAssertEqual(try day.part2(), 314)
    }

    func testDay16() throws {
        let day = Day16()
        XCTAssertEqual(try day.part1(), 52611030)
        XCTAssertEqual(try day.part2(), 52541026)
    }

    func testDay17() throws {
        let day = Day17()
        XCTAssertEqual(try day.part1(), 4800)
        XCTAssertEqual(try day.part2(), 982279)
    }
}
