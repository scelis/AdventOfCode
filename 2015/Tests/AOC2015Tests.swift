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
}
