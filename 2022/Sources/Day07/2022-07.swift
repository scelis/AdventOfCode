import AdventKit
import Algorithms
import Foundation

public class Day07: Day<Int, Int> {
    private enum Command {
        case cd(String)
        case ls

        init?(_ components: [String]) {
            guard components[0] == "$" else { return nil }
            switch components[1] {
            case "ls": self = .ls
            case "cd": self = .cd(components[2])
            default: fatalError()
            }
        }
    }

    private lazy var graph = {
        let graph = Graph<String, Int>()
        graph.addNode(id: "/", value: 0)

        var currentCommand: Command?
        var currentPath: [String] = []

        inputLines
            .map { $0.components(separatedBy: .whitespaces) }
            .forEach { components in
                if let command = Command(components) {
                    switch command {
                    case .ls:
                        currentCommand = command
                    case .cd(let dir):
                        switch dir {
                        case "/": currentPath.removeAll()
                        case "..": currentPath.removeLast()
                        default: currentPath.append(dir)
                        }
                        currentCommand = nil
                    }
                } else if let currentCommand, case .ls = currentCommand {
                    let size = (components[0] == "dir") ? 0 : Int(components[0])!
                    let name = components[1]
                    let currentPathString = currentPath.toFilePath()
                    let childPathString = (currentPath + [name]).toFilePath()
                    graph.addNode(id: childPathString, value: size)
                    try! graph.addConnection(from: currentPathString, to: childPathString, bidirectional: false)
                } else {
                    fatalError("Unknown output")
                }
            }

        return graph
    }()

    private lazy var directorySizes: [String: Int] = {
        var sizes: [String: Int] = [:]

        func calculateAndCacheSize(nodeId: String) -> Int {
            var size = 0
            for child in try! graph.nodesAccessible(from: nodeId) {
                let childSize = graph.value(of: child)!
                if childSize == 0 {
                    size += calculateAndCacheSize(nodeId: child)
                } else {
                    size += childSize
                }
            }
            sizes[nodeId] = size
            return size
        }

        _ = calculateAndCacheSize(nodeId: "/")

        return sizes
    }()

    public override func part1() throws -> Int {
        return directorySizes
            .values
            .filter { $0 <= 100000 }
            .sorted(by: >)
            .reduce(0, +)
    }

    public override func part2() throws -> Int {
        let spaceAvailable = 70000000 - directorySizes["/"]!
        return directorySizes
            .values
            .filter { spaceAvailable + $0 >= 30000000 }
            .sorted(by: <)
            .first!
    }
}
