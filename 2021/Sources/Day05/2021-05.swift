import AdventKit
import Algorithms
import Foundation

public class Day05: Day<Int, Int> {
    struct Line {
        var first: Coordinate2D
        var second: Coordinate2D

        var isHorizontal: Bool { first.x == second.x }
        var isVertical: Bool { first.y == second.y }
        var isDiagonal: Bool { !isHorizontal && !isVertical }

        var points: [Coordinate2D] {
            var array: [Coordinate2D] = []

            var current = first
            array.append(current)
            while current != second {
                if second.x > current.x {
                    current.x += 1
                } else if second.x < current.x {
                    current.x -= 1
                }

                if second.y > current.y {
                    current.y += 1
                } else if second.y < current.y {
                    current.y -= 1
                }

                array.append(current)
            }

            return array
        }
    }

    func parse(line: String) -> Line {
        let coordinates = line
            .components(separatedBy: " -> ")
            .map(parse(coordinate:))
        return Line(first: coordinates[0], second: coordinates[1])
    }

    func parse(coordinate: String) -> Coordinate2D {
        let numbers = coordinate
            .components(separatedBy: ",")
            .map { Int($0)! }
        return Coordinate2D(x: numbers[0], y: numbers[1])
    }

    lazy var lines: [Line] = {
        return inputLines.map(parse(line:))
    }()

    func calculateOverlaps(allowDiagonals: Bool) -> Int {
        var lines = lines
        if !allowDiagonals {
            lines = lines.filter { $0.isDiagonal == false }
        }

        var points: [Coordinate2D : Int] = [:]
        for line in lines {
            for point in line.points {
                points[point] = (points[point] ?? 0) + 1
            }
        }

        return points
            .values
            .filter { $0 > 1}
            .count
    }

    public override func part1() throws -> Int {
        return calculateOverlaps(allowDiagonals: false)
    }

    public override func part2() throws -> Int {
        return calculateOverlaps(allowDiagonals: true)
    }
}
