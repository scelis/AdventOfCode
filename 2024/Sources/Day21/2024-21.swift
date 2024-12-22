import AdventKit
import Algorithms
import Foundation

struct Day21: Day {
    struct CharacterPair: Equatable, Hashable {
        var a: Character
        var b: Character
    }

    struct SolutionState: Equatable, Hashable {
        var from: Character
        var to: Character
        var depth: Int
    }

    struct Keypad: Sendable {
        var buttons: [[Character?]]
        var buttonCoordinateMap: [Character: Coordinate2D]
        var coordinateButtonMap: [Coordinate2D: Character]

        init(buttons: [[Character?]]) {
            self.buttons = buttons

            var buttonCoordinateMap: [Character: Coordinate2D] = [:]
            var coordinateButtonMap: [Coordinate2D: Character] = [:]
            for y in buttons.indices {
                for x in buttons[y].indices {
                    if let button = buttons[y][x] {
                        buttonCoordinateMap[button] = Coordinate2D(x: x, y: y)
                        coordinateButtonMap[Coordinate2D(x: x, y: y)] = button
                    }
                }
            }
            self.buttonCoordinateMap = buttonCoordinateMap
            self.coordinateButtonMap = coordinateButtonMap
        }

        func nextLevelPaths(
            from: Character,
            to: Character,
            memo: inout [CharacterPair: [[Character]]]
        ) throws -> [[Character]] {
            if from == to {
                return [["A"]]
            }

            if let paths = memo[CharacterPair(a: from, b: to)] {
                return paths
            }

            let fromCoordinate = buttonCoordinateMap[from]!
            let toCoordinate = buttonCoordinateMap[to]!
            let dx = toCoordinate.x - fromCoordinate.x
            let dy = toCoordinate.y - fromCoordinate.y

            let horizontalSteps: [Direction] = Array(repeating: (dx > 0) ? .right : .left, count: abs(dx))
            let verticalSteps: [Direction] = Array(repeating: (dy > 0) ? .down : .up, count: abs(dy))
            let paths: [[Direction]] = {
                if dx != 0 && dy != 0 {
                    var possibilities: [[Direction]] = []
                    if coordinateButtonMap[fromCoordinate.step(inDirection: .right, distance: dx)] != nil {
                        possibilities.append(horizontalSteps + verticalSteps)
                    }
                    if coordinateButtonMap[fromCoordinate.step(inDirection: .down, distance: dy)] != nil {
                        possibilities.append(verticalSteps + horizontalSteps)
                    }
                    return possibilities
                } else if dx != 0 {
                    return [horizontalSteps]
                } else {
                    return [verticalSteps]
                }
            }()

            let characters = paths.map({ $0.map({ $0.character }) + "A" })
            memo[CharacterPair(a: from, b: to)] = characters
            return characters
        }
    }

    let numericKeypad = Keypad(
        buttons: [
            ["7", "8", "9"],
            ["4", "5", "6"],
            ["1", "2", "3"],
            [nil, "0", "A"]
        ]
    )

    let directionalKeypad = Keypad(
        buttons: [
            [nil, "^", "A"],
            ["<", "v", ">"]
        ]
    )

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        try solve(depth: 3)
    }

    func part2() async throws -> Int {
        try solve(depth: 26)
    }

    func solve(depth: Int) throws -> Int {
        var pathsMemo: [CharacterPair: [[Character]]] = [:]
        var solutionsMemo: [SolutionState: Int] = [:]
        return try inputLines()
            .map { code in
                try minimumButtonPresses(
                    code: code,
                    keypad: numericKeypad,
                    depth: depth,
                    pathsMemo: &pathsMemo,
                    solutionsMemo: &solutionsMemo
                ) * Int(code.prefix(3))!
            }
            .reduce(0, +)
    }

    func minimumButtonPresses(
        code: String,
        keypad: Keypad,
        depth: Int,
        pathsMemo: inout [CharacterPair: [[Character]]],
        solutionsMemo: inout [SolutionState: Int]
    ) throws -> Int {
        var total = 0
        var previousCharacter: Character = "A"
        for character in code {
            total += try minimumButtonPresses(
                from: previousCharacter,
                to: character,
                keypad: keypad,
                depth: depth,
                pathsMemo: &pathsMemo,
                solutionsMemo: &solutionsMemo
            )
            previousCharacter = character
        }
        return total
    }

    func minimumButtonPresses(
        from: Character,
        to: Character,
        keypad: Keypad,
        depth: Int,
        pathsMemo: inout [CharacterPair: [[Character]]],
        solutionsMemo: inout [SolutionState: Int]
    ) throws -> Int {
        if depth == 0 {
            return 1
        }

        if let solution = solutionsMemo[SolutionState(from: from, to: to, depth: depth)] {
            return solution
        }

        var minimum = Int.max
        for paths in try keypad.nextLevelPaths(from: from, to: to, memo: &pathsMemo) {
            var value = 0
            var previousChar: Character = "A"
            for character in paths {
                value += try minimumButtonPresses(
                    from: previousChar,
                    to: character,
                    keypad: directionalKeypad,
                    depth: depth - 1,
                    pathsMemo: &pathsMemo,
                    solutionsMemo: &solutionsMemo
                )
                previousChar = character
            }
            minimum = min(value, minimum)
        }

        solutionsMemo[SolutionState(from: from, to: to, depth: depth)] = minimum
        return minimum
    }
}

private extension Direction {
    var character: Character {
        switch self {
        case .left: return "<"
        case .right: return ">"
        case .down: return "v"
        case .up: return "^"
        default: fatalError("Unknown direction \(self)")
        }
    }
}
