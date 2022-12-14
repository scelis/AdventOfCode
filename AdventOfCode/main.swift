import AOC2022
import Foundation

let day = AOC2022.Day13()

let clock = ContinuousClock()
let time = try clock.measure {
    let part1 = try day.part1()
    let part2 = try day.part2()
    print("Part 1: \(part1)")
    print("Part 2: \(part2)")
}
print("Time: \(time)")
