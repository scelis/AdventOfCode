import AdventKit
import Foundation

public class Day11: Day<Int, String> {
    enum Color: Int {
        case black = 0
        case white = 1
    }

    private func runComputer(startOnWhite: Bool = false) -> [Coordinate2D<Int>: Color] {
        var direction = Direction.up
        var coordinate = Coordinate2D(x: 0, y: 0)
        var coordinatesPainted: [Coordinate2D<Int>: Color] = [:]

        if startOnWhite {
            coordinatesPainted[coordinate] = .white
        }

        let computer = IntcodeComputer(input: input)
        computer.run()

        while computer.state != .halted {
            while computer.outputBuffer.count >= 2 {
                let color = Color(rawValue: computer.readInt()!)
                coordinatesPainted[coordinate] = color
                let turn = computer.readInt()!
                if turn == 0 {
                    direction = direction.turnLeft()
                } else {
                    direction = direction.turnRight()
                }
                coordinate = coordinate.step(inDirection: direction)
            }

            if computer.state == .awaitingInput {
                let color = coordinatesPainted[coordinate] ?? .black
                computer.run(input: [color.rawValue])
            }
        }

        return coordinatesPainted
    }

    public override func part1() throws -> Int {
        let coordinatesPainted = runComputer()
        return coordinatesPainted.count
    }

    public override func part2() throws -> String {
        let coordinatesPainted = runComputer(startOnWhite: true)

        var output = "\n"
        let allCoordinates = coordinatesPainted.keys
        for y in allCoordinates.top!.y...allCoordinates.bottom!.y {
            for x in allCoordinates.left!.x...allCoordinates.right!.x {
                let color = coordinatesPainted[Coordinate2D(x: x, y: y)] ?? .black
                output += (color == .black) ? "⬛️" : "⬜️"
            }
            output += "\n"
        }

        return output
    }
}
