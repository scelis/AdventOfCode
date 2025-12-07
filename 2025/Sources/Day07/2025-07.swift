import AdventKit
import Foundation

struct Day07: Day {
    enum Tile: Character {
        case start = "S"
        case splitter = "^"
        case empty = "."
    }

    func run() async throws -> (Int, Int) {
        let tiles = parseTiles()
        let start = findStart(tiles: tiles)!
        var beams: [Coordinate2D: Int] = [start: 1]
        var splits = 0

        while beams.first!.key.y < tiles.count - 1 {
            beams = beams.reduce(into: [:]) { result, beam in
                let next = beam.key.step(inDirection: .down)
                switch tiles[next] {
                case .empty:
                    result[next, default: 0] += beam.value
                case .splitter:
                    splits += 1
                    result[next.step(inDirection: .left), default: 0] += beam.value
                    result[next.step(inDirection: .right), default: 0] += beam.value
                default:
                    fatalError()
                }
            }
        }

        return (splits, beams.values.reduce(0, +))
    }

    func findStart(tiles: [[Tile]]) -> Coordinate2D? {
        for (y, row) in tiles.enumerated() {
            for (x, tile) in row.enumerated() {
                if tile == .start {
                    return Coordinate2D(x: x, y: y)
                }
            }
        }
        return nil
    }

    func parseTiles() -> [[Tile]] {
        inputLines().map { $0.compactMap(Tile.init) }
    }
}
