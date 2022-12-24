import Foundation
import XCTest
@testable import AOC2022

class AOC2022Tests: XCTestCase {
    func testDay01() throws {
        let day = Day01()
        XCTAssertEqual(try day.part1(), 71934)
        XCTAssertEqual(try day.part2(), 211447)
    }

    func testDay02() throws {
        let day = Day02()
        XCTAssertEqual(try day.part1(), 12855)
        XCTAssertEqual(try day.part2(), 13726)
    }

    func testDay03() throws {
        let day = Day03()
        XCTAssertEqual(try day.part1(), 7908)
        XCTAssertEqual(try day.part2(), 2838)
    }

    func testDay04() throws {
        let day = Day04()
        XCTAssertEqual(try day.part1(), 483)
        XCTAssertEqual(try day.part2(), 874)
    }

    func testDay05() throws {
        let day = Day05()
        XCTAssertEqual(try day.part1(), "RTGWZTHLD")
        XCTAssertEqual(try day.part2(), "STHGRZZFR")
    }

    func testDay06() throws {
        let day = Day06()
        XCTAssertEqual(try day.part1(), 1640)
        XCTAssertEqual(try day.part2(), 3613)
    }

    func testDay07() throws {
        let day = Day07()
        XCTAssertEqual(try day.part1(), 1141028)
        XCTAssertEqual(try day.part2(), 8278005)
    }

    func testDay08() throws {
        let day = Day08()
        XCTAssertEqual(try day.part1(), 1814)
        XCTAssertEqual(try day.part2(), 330786)
    }

    func testDay09() throws {
        let day = Day09()
        XCTAssertEqual(try day.part1(), 6026)
        XCTAssertEqual(try day.part2(), 2273)
    }

    func testDay10() throws {
        let day = Day10()
        XCTAssertEqual(try day.part1(), 13740)
        XCTAssertEqual(try day.part2().trimmingCharacters(in: .newlines), """
####.#..#.###..###..####.####..##..#....
...#.#..#.#..#.#..#.#....#....#..#.#....
..#..#..#.#..#.#..#.###..###..#....#....
.#...#..#.###..###..#....#....#....#....
#....#..#.#....#.#..#....#....#..#.#....
####..##..#....#..#.#....####..##..####.
""")
    }

    func testDay11() throws {
        let day = Day11()
        XCTAssertEqual(try day.part1(), 67830)
        XCTAssertEqual(try day.part2(), 15305381442)
    }

    func testDay12() throws {
        let day = Day12()
        XCTAssertEqual(try day.part1(), 472)
        XCTAssertEqual(try day.part2(), 465)
    }

    func testDay13() throws {
        let day = Day13()
        XCTAssertEqual(try day.part1(), 5684)
        XCTAssertEqual(try day.part2(), 22932)
    }

    func testDay14() throws {
        let day = Day14()
        XCTAssertEqual(try day.part1(), 1016)
        XCTAssertEqual(try day.part2(), 25402)
    }

    func testDay15() throws {
        let day = Day15()
        XCTAssertEqual(try day.part1(), 4951427)
        XCTAssertEqual(try day.part2(), 13029714573243)
    }
}
