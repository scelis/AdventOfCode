import Foundation
import XCTest
@testable import AOC2015

class AOC2015Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 138)
        XCTAssertEqual(parts.1, 1771)
    }

    func testDay02() async throws {
        let day = Day02()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1606483)
        XCTAssertEqual(parts.1, 3842356)
    }

    func testDay03() async throws {
        let day = Day03()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2081)
        XCTAssertEqual(parts.1, 2341)
    }

    func testDay04() async throws {
        let day = Day04()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 282749)
        XCTAssertEqual(parts.1, 9962624)
    }

    func testDay05() async throws {
        let day = Day05()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 236)
        XCTAssertEqual(parts.1, 51)
    }

    func testDay06() async throws {
        let day = Day06()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 377891)
        XCTAssertEqual(parts.1, 14110788)
    }

    func testDay07() async throws {
        let day = Day07()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 956)
        XCTAssertEqual(parts.1, 40149)
    }

    func testDay08() async throws {
        let day = Day08()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1350)
        XCTAssertEqual(parts.1, 2085)
    }

    func testDay09() async throws {
        let day = Day09()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 141)
        XCTAssertEqual(parts.1, 736)
    }

    func testDay10() async throws {
        let day = Day10()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 360154)
        XCTAssertEqual(parts.1, 5103798)
    }

    func testDay11() async throws {
        let day = Day11()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, "vzbxxyzz")
        XCTAssertEqual(parts.1, "vzcaabcc")
    }

    func testDay12() async throws {
        let day = Day12()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 191164)
        XCTAssertEqual(parts.1, 87842)
    }

    func testDay13() async throws {
        let day = Day13()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 664)
        XCTAssertEqual(parts.1, 640)
    }

    func testDay14() async throws {
        let day = Day14()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2696)
        XCTAssertEqual(parts.1, 1084)
    }

    func testDay15() async throws {
        let day = Day15()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 21367368)
        XCTAssertEqual(parts.1, 1766400)
    }

    func testDay16() async throws {
        let day = Day16()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 103)
        XCTAssertEqual(parts.1, 405)
    }
}
