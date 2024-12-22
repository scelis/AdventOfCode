import Foundation
import XCTest
@testable import AOC2024

class AOC2024Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 3508942)
        XCTAssertEqual(parts.1, 26593248)
    }

    func testDay02() async throws {
        let day = Day02()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 287)
        XCTAssertEqual(parts.1, 354)
    }

    func testDay03() async throws {
        let day = Day03()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 175015740)
        XCTAssertEqual(parts.1, 112272912)
    }

    func testDay04() async throws {
        let day = Day04()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2496)
        XCTAssertEqual(parts.1, 1967)
    }

    func testDay05() async throws {
        let day = Day05()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6034)
        XCTAssertEqual(parts.1, 6305)
    }

    func testDay06() async throws {
        let day = Day06()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 5444)
        XCTAssertEqual(parts.1, 1946)
    }

    func testDay07() async throws {
        let day = Day07()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 20665830408335)
        XCTAssertEqual(parts.1, 354060705047464)
    }

    func testDay08() async throws {
        let day = Day08()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 329)
        XCTAssertEqual(parts.1, 1190)
    }

    func testDay09() async throws {
        let day = Day09()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6291146824486)
        XCTAssertEqual(parts.1, 6307279963620)
    }

    func testDay10() async throws {
        let day = Day10()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 796)
        XCTAssertEqual(parts.1, 1942)
    }

    func testDay11() async throws {
        let day = Day11()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 199753)
        XCTAssertEqual(parts.1, 239413123020116)
    }

    func testDay12() async throws {
        let day = Day12()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1486324)
        XCTAssertEqual(parts.1, 898684)
    }

    func testDay13() async throws {
        let day = Day13()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 26810)
        XCTAssertEqual(parts.1, 108713182988244)
    }

    func testDay14() async throws {
        let day = Day14()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 209409792)
        XCTAssertEqual(parts.1, 8006)
    }

    func testDay15() async throws {
        let day = Day15()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1430439)
        XCTAssertEqual(parts.1, 1458740)
    }

    func testDay16() async throws {
        let day = Day16()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 98484)
        XCTAssertEqual(parts.1, 531)
    }

    func testDay17() async throws {
        let day = Day17()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, "7,1,2,3,2,6,7,2,5")
        XCTAssertEqual(parts.1, 202356708354602)
    }

    func testDay18() async throws {
        let day = Day18()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 282)
        XCTAssertEqual(parts.1, "64,29")
    }

    func testDay19() async throws {
        let day = Day19()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 308)
        XCTAssertEqual(parts.1, 662726441391898)
    }

    func testDay20() async throws {
        let day = Day20()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1521)
        XCTAssertEqual(parts.1, 1013106)
    }

    func testDay21() async throws {
        let day = Day21()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 224326)
        XCTAssertEqual(parts.1, 279638326609472)
    }
}
