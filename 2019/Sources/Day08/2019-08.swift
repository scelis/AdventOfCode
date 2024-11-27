import AdventKit2
import Foundation

struct Day08: Day {
    let imageWidth = 25
    let imageHeight = 6

    func run() async throws -> (Int, String) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var layer = 0
        var x = 0
        var y = 0
        var layerData: [Character: Int] = [:]

        var layerDatas: [[Character: Int]] = []
        for character in input() {
            layerData[character] = (layerData[character] ?? 0) + 1

            x = (x + 1) % imageWidth
            if x == 0 {
                y = (y + 1) % imageHeight
                if y == 0 {
                    layer += 1
                    layerDatas.append(layerData)
                    layerData = [:]
                }
            }
        }

        let minData = layerDatas.min { a, b -> Bool in
            return (a[Character("0")] ?? 0) < (b[Character("0")] ?? 0)
        }

        let result = (minData![Character("1")] ?? 0) * (minData![Character("2")] ?? 0)
        return result
    }

    func part2() async throws -> String {
        var x = 0
        var y = 0
        var result: [[String]] = .init(repeating: .init(repeating: "2", count: imageWidth), count: imageHeight)

        for character in input() {
            switch character {
            case "0", "1":
                if result[y][x] == "2" {
                    result[y][x] = String(character)
                }
            case "2":
                break
            default:
                fatalError()
            }

            x = (x + 1) % imageWidth
            if x == 0 {
                y = (y + 1) % imageHeight
            }
        }

        var answer = ""
        for line in result {
            answer += "\n"
            answer += line.joined()
        }
        return answer
    }
}
