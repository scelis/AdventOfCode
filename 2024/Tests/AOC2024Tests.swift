import Foundation
import Testing
@testable import AOC2024

@Suite struct AOC2024Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run()
        #expect(parts.0 == 3508942)
        #expect(parts.1 == 26593248)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run()
        #expect(parts.0 == 287)
        #expect(parts.1 == 354)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run()
        #expect(parts.0 == 175015740)
        #expect(parts.1 == 112272912)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run()
        #expect(parts.0 == 2496)
        #expect(parts.1 == 1967)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run()
        #expect(parts.0 == 6034)
        #expect(parts.1 == 6305)
    }

    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run()
        #expect(parts.0 == 5444)
        #expect(parts.1 == 1946)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run()
        #expect(parts.0 == 20665830408335)
        #expect(parts.1 == 354060705047464)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run()
        #expect(parts.0 == 329)
        #expect(parts.1 == 1190)
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run()
        #expect(parts.0 == 6291146824486)
        #expect(parts.1 == 6307279963620)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run()
        #expect(parts.0 == 796)
        #expect(parts.1 == 1942)
    }

    @Test func day11() async throws {
        let day = Day11()
        let parts = try await day.run()
        #expect(parts.0 == 199753)
        #expect(parts.1 == 239413123020116)
    }

    @Test func day12() async throws {
        let day = Day12()
        let parts = try await day.run()
        #expect(parts.0 == 1486324)
        #expect(parts.1 == 898684)
    }

    @Test func day13() async throws {
        let day = Day13()
        let parts = try await day.run()
        #expect(parts.0 == 26810)
        #expect(parts.1 == 108713182988244)
    }

    @Test func day14() async throws {
        let day = Day14()
        let parts = try await day.run()
        #expect(parts.0 == 209409792)
        #expect(parts.1 == 8006)
    }

    @Test func day15() async throws {
        let day = Day15()
        let parts = try await day.run()
        #expect(parts.0 == 1430439)
        #expect(parts.1 == 1458740)
    }

    @Test func day16() async throws {
        let day = Day16()
        let parts = try await day.run()
        #expect(parts.0 == 98484)
        #expect(parts.1 == 531)
    }

    @Test func day17() async throws {
        let day = Day17()
        let parts = try await day.run()
        #expect(parts.0 == "7,1,2,3,2,6,7,2,5")
        #expect(parts.1 == 202356708354602)
    }

    @Test func day18() async throws {
        let day = Day18()
        let parts = try await day.run()
        #expect(parts.0 == 282)
        #expect(parts.1 == "64,29")
    }

    @Test func day19() async throws {
        let day = Day19()
        let parts = try await day.run()
        #expect(parts.0 == 308)
        #expect(parts.1 == 662726441391898)
    }

    @Test func day20() async throws {
        let day = Day20()
        let parts = try await day.run()
        #expect(parts.0 == 1521)
        #expect(parts.1 == 1013106)
    }

    @Test func day21() async throws {
        let day = Day21()
        let parts = try await day.run()
        #expect(parts.0 == 224326)
        #expect(parts.1 == 279638326609472)
    }

    @Test func day22() async throws {
        let day = Day22()
        let parts = try await day.run()
        #expect(parts.0 == 17005483322)
        #expect(parts.1 == 1910)
    }

    @Test func day23() async throws {
        let day = Day23()
        let parts = try await day.run()
        #expect(parts.0 == 1156)
        #expect(parts.1 == "bx,cx,dr,dx,is,jg,km,kt,li,lt,nh,uf,um")
    }

    @Test func day24() async throws {
        let day = Day24()
        let parts = try await day.run()
        #expect(parts.0 == 46362252142374)
        #expect(parts.1 == "cbd,gmh,jmq,qrh,rqf,z06,z13,z38")
    }

    @Test func day25() async throws {
        let day = Day25()
        let parts = try await day.run()
        #expect(parts.0 == 3395)
    }
}
