import AdventKit
import Foundation

struct Day09: Day {
    func isFile(_ index: Int) -> Bool { index % 2 == 0 }
    func fileID(_ index: Int) -> Int { index / 2 }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let digits = input().compactMap { Int(String($0)) }
        var leftIndex = 0
        var leftBlocksFilled = 0
        var rightIndex = digits.count - 1
        var rightBlocksMoved = 0
        var diskIndex = 0
        var checksum = 0

        while leftIndex < rightIndex {
            if isFile(leftIndex) {
                let fileSize = digits[leftIndex]
                if fileSize > 0 {
                    let fileID = fileID(leftIndex)
                    for _ in 0..<fileSize {
                        checksum += diskIndex * fileID
                        diskIndex += 1
                    }
                }
                leftIndex += 1
            } else if !isFile(rightIndex) {
                rightIndex -= 1
            } else {
                let spaceAvailable = digits[leftIndex] - leftBlocksFilled
                let diskAvailable = digits[rightIndex] - rightBlocksMoved
                let blocksToMove = min(spaceAvailable, diskAvailable)
                let fileID = fileID(rightIndex)
                for _ in 0..<blocksToMove {
                    checksum += diskIndex * fileID
                    diskIndex += 1
                }
                leftBlocksFilled += blocksToMove
                rightBlocksMoved += blocksToMove
                if leftBlocksFilled == digits[leftIndex] {
                    leftIndex += 1
                    leftBlocksFilled = 0
                }
                if rightBlocksMoved == digits[rightIndex] {
                    rightIndex -= 1
                    rightBlocksMoved = 0
                }
            }
        }

        if isFile(rightIndex) {
            let fileID = fileID(rightIndex)
            for _ in 0..<(digits[rightIndex] - rightBlocksMoved) {
                checksum += diskIndex * fileID
                diskIndex += 1
            }
        }

        return checksum
    }

    func part2() async throws -> Int {
        enum Entry {
            case file(fileID: Int, fileSize: Int)
            case space(spaceSize: Int)
        }

        var entries = input()
            .compactMap { Int(String($0)) }
            .enumerated()
            .map { (index, size) -> Entry in
                isFile(index) ? .file(fileID: fileID(index), fileSize: size) : .space(spaceSize: size)
            }

        var right = entries.count - 1
        while right >= 0 {
            switch entries[right] {
            case .space:
                right -= 1
            case .file(_, let fileSize):
                for left in 0..<right {
                    if case .space(let spaceSize) = entries[left] {
                        if spaceSize == fileSize {
                            entries[left] = entries[right]
                            entries[right] = .space(spaceSize: fileSize)
                            break
                        } else if spaceSize > fileSize {
                            entries.insert(entries[right], at: left)
                            right += 1
                            entries[right] = .space(spaceSize: fileSize)
                            entries[left + 1] = .space(spaceSize: spaceSize - fileSize)
                            break
                        }
                    }
                }

                right -= 1
            }
        }

        var diskIndex = 0
        var checksum = 0
        entries.forEach { entry in
            switch entry {
            case .file(let fileID, let fileSize):
                for _ in 0..<fileSize {
                    checksum += diskIndex * fileID
                    diskIndex += 1
                }
            case .space(let spaceSize):
                diskIndex += spaceSize
            }
        }

        return checksum
    }
}
