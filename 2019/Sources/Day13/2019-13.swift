import AdventKit
import Algorithms
import Foundation

struct Day13: Day {
    enum Tile: Int {
        case empty = 0
        case wall = 1
        case block = 2
        case horizontalPaddle = 3
        case ball = 4
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer.run()

        var output: [Coordinate2D: Tile] = [:]
        for instruction in computer.outputBuffer.chunks(ofCount: 3) {
            let i = instruction.startIndex
            let coordinate = Coordinate2D(x: instruction[i], y: instruction[i + 1])
            output[coordinate] = Tile(rawValue: instruction[i + 2])
        }

        return output.values.reduce(0) { (result, tile) -> Int in
            return (tile == .block) ? result + 1 : result
        }
    }

    func part2() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer[0] = 2
        computer.run()

        var score = 0
        var ballPosition: Coordinate2D?
        var paddlePosition: Coordinate2D?
        var blockPositions: Set<Coordinate2D> = []
        while true {
            for instruction in computer.outputBuffer.chunks(ofCount: 3) {
                let i = instruction.startIndex
                let coordinate = Coordinate2D(x: instruction[i], y: instruction[i + 1])
                if coordinate == Coordinate2D(x: -1, y: 0) {
                    score = instruction[i + 2]
                } else {
                    let tile = Tile(rawValue: instruction[i + 2])!
                    if tile == .ball {
                        ballPosition = coordinate
                    }
                    if tile == .horizontalPaddle {
                        paddlePosition = coordinate
                    }
                    if tile == .block {
                        blockPositions.insert(coordinate)
                    } else {
                        blockPositions.remove(coordinate)
                    }
                }
            }
            computer.outputBuffer = []

            if
                !blockPositions.isEmpty,
                computer.state == .awaitingInput,
                let ballPosition = ballPosition,
                let paddlePosition = paddlePosition
            {
                if ballPosition.x < paddlePosition.x {
                    computer.run(input: [-1])
                } else if ballPosition.x > paddlePosition.x {
                    computer.run(input: [1])
                } else {
                    computer.run(input: [0])
                }
            } else {
                break
            }
        }

        return score
    }
}
