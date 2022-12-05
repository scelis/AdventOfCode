import AdventKit
import Foundation

public class Day17: Day<Int, Int> {
    enum Tile: Character {
        case scaffold = "#"
        case space = "."
        case robotUp = "^"
        case robotDown = "v"
        case robotLeft = "<"
        case robotRight = ">"
        case robotFalling = "X"

        var hasScaffold: Bool {
            switch self {
            case .space, .robotFalling: return false
            default: return true
            }
        }

        init?(int: Int) {
            if
                let scalar = UnicodeScalar(int),
                let tile = Tile(rawValue: Character(scalar))
            {
                self = tile
            } else {
                return nil
            }
        }
    }

    public override func part1() throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer.run()

        prettyPrint(integers: computer.outputBuffer)
        let tiles = readTiles(integers: computer.outputBuffer)

        var sum = 0
        tiles.forEach { coordinate, tile in
            if
                tile.hasScaffold,
                let up = tiles[coordinate.step(inDirection: .up)],
                up.hasScaffold,
                let left = tiles[coordinate.step(inDirection: .left)],
                left.hasScaffold,
                let down = tiles[coordinate.step(inDirection: .down)],
                down.hasScaffold,
                let right = tiles[coordinate.step(inDirection: .right)],
                right.hasScaffold
            {
                sum += coordinate.x * coordinate.y
            }
        }

        return sum
    }

    public override func part2() throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer[0] = 2
        computer.run()

        let commands: [String] = [
            "A,C,A,B,C,A,B,C,A,B",
            "L,12,L,12,L,6,L,6",
            "L,12,L,6,R,12,R,8",
            "R,8,R,4,L,12",
            "n"
        ]

        for command in commands {
            prettyPrint(integers: computer.outputBuffer)
            computer.clearOutputBuffer()
            print("> \(command)")
            computer.run(input: parse(command: command))
        }

        prettyPrint(integers: computer.outputBuffer)
        return computer.outputBuffer.last!
    }

    func readTiles(integers: [Int]) -> [Coordinate2D<Int>: Tile] {
        var tiles: [Coordinate2D<Int>: Tile] = [:]
        var x = 0
        var y = 0
        for int in integers {
            if int == 10 {
                x = 0
                y += 1
            } else if let tile = Tile(int: int) {
                tiles[Coordinate2D(x: x, y: y)] = tile
                x += 1
            } else {
                fatalError()
            }
        }

        return tiles
    }

    func parse(command: String) -> [Int] {
        var array = command.map({ Int($0.asciiValue!) })
        if array.count > 20 {
            fatalError()
        }
        array.append(10)
        return array
    }

    func prettyPrint(integers: [Int]) {
        var output = ""
        for int in integers {
            output += String(Character(UnicodeScalar(int)!))
        }
        print(output.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
