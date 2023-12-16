import Foundation
import XCTest
@testable import AOC2022

class AOC2022Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 71934)
        XCTAssertEqual(parts.1, 211447)
    }

    func testDay02() async throws {
        let day = Day02()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 12855)
        XCTAssertEqual(parts.1, 13726)
    }

    func testDay03() async throws {
        let day = Day03()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 7908)
        XCTAssertEqual(parts.1, 2838)
    }

    func testDay04() async throws {
        let day = Day04()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 483)
        XCTAssertEqual(parts.1, 874)
    }

    func testDay05() async throws {
        let day = Day05()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, "RTGWZTHLD")
        XCTAssertEqual(parts.1, "STHGRZZFR")
    }

    func testDay06() async throws {
        let day = Day06()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1640)
        XCTAssertEqual(parts.1, 3613)
    }

    func testDay07() async throws {
        let day = Day07()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1141028)
        XCTAssertEqual(parts.1, 8278005)
    }

    func testDay08() async throws {
        let day = Day08()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1814)
        XCTAssertEqual(parts.1, 330786)
    }

    func testDay09() async throws {
        let day = Day09()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6026)
        XCTAssertEqual(parts.1, 2273)
    }

    func testDay10() async throws {
        let day = Day10()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 13740)
        XCTAssertEqual(parts.1.trimmingCharacters(in: .newlines), """
####.#..#.###..###..####.####..##..#....
...#.#..#.#..#.#..#.#....#....#..#.#....
..#..#..#.#..#.#..#.###..###..#....#....
.#...#..#.###..###..#....#....#....#....
#....#..#.#....#.#..#....#....#..#.#....
####..##..#....#..#.#....####..##..####.
""")
    }

    func testDay11() async throws {
        let day = Day11()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 67830)
        XCTAssertEqual(parts.1, 15305381442)
    }

    func testDay12() async throws {
        let day = Day12()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 472)
        XCTAssertEqual(parts.1, 465)
    }

    func testDay13() async throws {
        let day = Day13()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 5684)
        XCTAssertEqual(parts.1, 22932)
    }

    func testDay14() async throws {
        let day = Day14()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1016)
        XCTAssertEqual(parts.1, 25402)
    }

    func testDay15() async throws {
        let day = Day15()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 4951427)
        XCTAssertEqual(parts.1, 13029714573243)
    }
}
