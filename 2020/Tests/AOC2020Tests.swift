import Foundation
import XCTest
@testable import AOC2020

class AOC2020Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 840324)
        XCTAssertEqual(parts.1, 170098110)
    }

    func testDay02() async throws {
        let day = Day02()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 638)
        XCTAssertEqual(parts.1, 699)
    }

    func testDay03() async throws {
        let day = Day03()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 198)
        XCTAssertEqual(parts.1, 5140884672)
    }

    func testDay04() async throws {
        let day = Day04()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 202)
        XCTAssertEqual(parts.1, 137)
    }

    func testDay05() async throws {
        let day = Day05()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 850)
        XCTAssertEqual(parts.1, 599)
    }

    func testDay06() async throws {
        let day = Day06()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6596)
        XCTAssertEqual(parts.1, 3219)
    }

    func testDay07() async throws {
        let day = Day07()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 161)
        XCTAssertEqual(parts.1, 30899)
    }

    func testDay08() async throws {
        let day = Day08()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1337)
        XCTAssertEqual(parts.1, 1358)
    }

    func testDay09() async throws {
        let day = Day09()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 26796446)
        XCTAssertEqual(parts.1, 3353494)
    }

    func testDay10() async throws {
        let day = Day10()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2100)
        XCTAssertEqual(parts.1, 16198260678656)
    }

    func testDay11() async throws {
        let day = Day11()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2483)
        XCTAssertEqual(parts.1, 2285)
    }

    func testDay12() async throws {
        let day = Day12()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 636)
        XCTAssertEqual(parts.1, 26841)
    }

    func testDay13() async throws {
        let day = Day13()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 153)
        XCTAssertEqual(parts.1, 471793476184394)
    }

    func testDay14() async throws {
        let day = Day14()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 10050490168421)
        XCTAssertEqual(parts.1, 2173858456958)
    }

    func testDay15() async throws {
        let day = Day15()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 614)
        XCTAssertEqual(parts.1, 1065)
    }

    func testDay16() async throws {
        let day = Day16()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 25972)
        XCTAssertEqual(parts.1, 622670335901)
    }
}
