import Foundation

public enum Direction: String {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
    case northEast = "NE"
    case northWest = "NW"
    case southEast = "SE"
    case southWest = "SW"

    public static let up = Direction.north
    public static let down = Direction.south
    public static let right = Direction.east
    public static let left = Direction.west

    public init?(rawValue: String) {
        switch rawValue {
        case "N", "U": self = .north
        case "S", "D": self = .south
        case "E", "R": self = .east
        case "W", "L": self = .west
        case "NE": self = .northEast
        case "NW": self = .northWest
        case "SE": self = .southEast
        case "SW": self = .southWest
        default: return nil
        }
    }

    public static let cardinalDirections: Set<Direction> = [.north, .east, .south, .west]
    public static let intercardinalDirections: Set<Direction> = [.northEast, .southEast, .southWest, .northWest]
    public static let cardinalAndIntercardinalDirections: Set<Direction> = cardinalDirections.union(intercardinalDirections)

    private static let clockwise: [Direction] = [
        .north, .northEast, .east, .southEast, .south, .southWest, .west, .northWest
    ]

    private func clockwiseShifted(amount: Int) -> Direction {
        let index = Self.clockwise.firstIndex(of: self)!
        var shiftedIndex = (index + amount) % Self.clockwise.count
        if shiftedIndex < 0 {
            shiftedIndex += Self.clockwise.count
        }
        return Self.clockwise[shiftedIndex]
    }

    public func turnRight(times: Int = 1) -> Direction {
        return clockwiseShifted(amount: times * 2)
    }

    public func turnLeft(times: Int = 1) -> Direction {
        return clockwiseShifted(amount: times * -2)
    }

    public func turnAround(times: Int = 1) -> Direction {
        return clockwiseShifted(amount: times * 4)
    }

    public func turnRight(degrees: Int) -> Direction {
        return clockwiseShifted(amount: degrees / 45)
    }

    public func turnLeft(degrees: Int) -> Direction {
        return clockwiseShifted(amount: -degrees / 45)
    }

    public var dx: Int {
        switch self {
        case .north, .south: return 0
        case .west, .southWest, .northWest: return -1
        case .east, .southEast, .northEast: return 1
        }
    }

    public var dy: Int {
        switch self {
        case .north, .northEast, .northWest: return -1
        case .south, .southEast, .southWest: return 1
        case .west, .east: return 0
        }
    }
}
