import AdventKit
import Foundation

public struct Day07: Day {
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

    private struct Item: GraphNode {
        enum ItemType: Equatable {
            case file(Int)
            case directory
        }

        var itemType: ItemType
        var path: String
        var id: String { path }

        var size: Int {
            switch itemType {
            case .file(let size): return size
            case .directory: return 0
            }
        }
    }

    private static var graph: Graph<Item> = {
        let graph = Graph<Item>()
        graph.add(node: Item(itemType: .directory, path: "/"))

        var currentCommand: Command?
        var currentPath: [String] = []

        Self.inputLines()
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
                    let name = components[1]
                    let currentPathString = currentPath.toFilePath()
                    let childPathString = (currentPath + [name]).toFilePath()
                    if components[0] == "dir" {
                        graph.add(node: Item(itemType: .directory, path: childPathString))
                    } else {
                        let size = Int(components[0])!
                        graph.add(node: Item(itemType: .file(size), path: childPathString))
                    }
                    try! graph.addConnection(from: currentPathString, to: childPathString, bidirectional: false)
                } else {
                    fatalError("Unknown output")
                }
            }

        return graph
    }()

    private static var directorySizes: [String: Int] = {
        var sizes: [String: Int] = [:]

        func calculateAndCacheSize(nodeID: String) -> Int {
            var size = 0
            for childID in try! graph.connections(from: nodeID).keys {
                let childNode = try! graph.node(withID: childID)
                switch childNode.itemType {
                case .directory:
                    size += calculateAndCacheSize(nodeID: childNode.id)
                case .file(let childSize):
                    size += childSize
                }
            }
            sizes[nodeID] = size
            return size
        }

        _ = calculateAndCacheSize(nodeID: "/")

        return sizes
    }()

    public func part1() async throws -> Int {
        return Self.directorySizes
            .values
            .filter { $0 <= 100000 }
            .sorted(by: >)
            .reduce(0, +)
    }

    public func part2() async throws -> Int {
        let spaceAvailable = 70000000 - Self.directorySizes["/"]!
        return Self.directorySizes
            .values
            .filter { spaceAvailable + $0 >= 30000000 }
            .sorted(by: <)
            .first!
    }
}
