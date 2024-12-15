@testable import AOC2024
import Foundation

let day = AOC2024.Day15()
let clock = ContinuousClock()
let time = try await clock.measure {
    async let parts = day.run()
    print("Part 1: \(try await parts.0)")
    print("Part 2: \(try await parts.1)")
}
print("Time: \(time)")
