import AdventKit2
import Algorithms
import Foundation

struct Day04: Day {
    class Square {
        var value: Int
        var marked: Bool = false

        init(value: Int) {
            self.value = value
        }
    }

    class Bingo {
        var rows: [[Square]]

        init(rows: [[Square]]) {
            self.rows = rows
        }

        var hasBingo: Bool {
            outer: for row in rows {
                for square in row {
                    if !square.marked {
                        continue outer
                    }
                }
                return true
            }

            outer: for i in 0..<rows.count {
                for row in rows {
                    if !row[i].marked {
                        continue outer
                    }
                }
                return true
            }

            return false
        }

        func score(finalNumber: Int) -> Int {
            var score = 0

            for row in rows {
                for square in row {
                    if !square.marked {
                        score += square.value
                    }
                }
            }

            return score * finalNumber
        }

        func mark(number: Int) {
            for row in rows {
                for square in row {
                    if square.value == number {
                        square.marked = true
                    }
                }
            }
        }
    }

    func numbersAndBoards() -> ([Int], [Bingo]) {
        var numbers: [Int] = []
        var boards: [Bingo] = []
        var currentBoard: [[Square]] = []

        for line in input().components(separatedBy: .newlines) {
            if numbers.isEmpty {
                numbers = line.components(separatedBy: ",").map({ Int($0)! })
            } else if line.isEmpty {
                if !currentBoard.isEmpty {
                    boards.append(Bingo(rows: currentBoard))
                    currentBoard.removeAll()
                }
            } else {
                currentBoard.append(
                    line
                        .components(separatedBy: .whitespacesAndNewlines)
                        .compactMap { Int($0) }
                        .map { Square(value: $0) }
                )
            }
        }

        if !currentBoard.isEmpty {
            boards.append(Bingo(rows: currentBoard))
        }

        return (numbers, boards)
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let (numbers, boards) = numbersAndBoards()

        for number in numbers {
            var bestScore = 0

            for board in boards {
                board.mark(number: number)
                if board.hasBingo {
                    bestScore = max(bestScore, board.score(finalNumber: number))
                }
            }

            if bestScore > 0 {
                return bestScore
            }
        }

        fatalError()
    }

    func part2() async throws -> Int {
        var (numbers, boards) = numbersAndBoards()

        for number in numbers {
            var lastScore = Int.max
            var updated: [Bingo] = []

            for board in boards {
                board.mark(number: number)
                if board.hasBingo {
                    lastScore = min(lastScore, board.score(finalNumber: number))
                } else {
                    updated.append(board)
                }
            }

            if updated.isEmpty {
                return lastScore
            }

            boards = updated
        }

        fatalError()
    }
}
