import AdventKit
import Foundation
import IntcodeComputer

class Day13: Day {
    enum Tile: Int {
        case empty = 0
        case wall = 1
        case block = 2
        case horizontalPaddle = 3
        case ball = 4
    }

    override func part1() -> String {
        let computer = IntcodeComputer(input: inputString)
        computer.run()

        var output: [Coordinate2D<Int>: Tile] = [:]
        for instruction in computer.outputBuffer.chunks(ofCount: 3) {
            let coordinate = Coordinate2D(x: instruction[0], y: instruction[1])
            output[coordinate] = Tile(rawValue: instruction[2])
        }

        return output.values.reduce(0) { (result, tile) -> Int in
            return (tile == .block) ? result + 1 : result
        }.description
    }

    override func part2() -> String {
        let computer = IntcodeComputer(input: inputString)
        computer[0] = 2
        computer.run()

        var score = 0
        var ballPosition: Coordinate2D<Int>?
        var paddlePosition: Coordinate2D<Int>?
        var blockPositions: Set<Coordinate2D<Int>> = []
        while true {
            for instruction in computer.outputBuffer.chunks(ofCount: 3) {
                let coordinate = Coordinate2D(x: instruction[0], y: instruction[1])
                if coordinate == Coordinate2D(x: -1, y: 0) {
                    score = instruction[2]
                } else {
                    let tile = Tile(rawValue: instruction[2])!
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

        return score.description
    }
}

Day13().run()
