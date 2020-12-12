import Foundation

public enum CardinalDirection: String {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
    case northEast = "NE"
    case northWest = "NW"
    case southEast = "SE"
    case southWest = "SW"

    public static var mainDirections: [CardinalDirection] = [.north, .east, .south, .west]
    public static var allDirections: [CardinalDirection] = [.northWest, .north, .northEast, .east, .southEast, .south, .southWest, .west]

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

    public var opposite: CardinalDirection {
        switch self {
        case .north: return .south
        case .northEast: return .southWest
        case .northWest: return .southEast
        case .south: return .north
        case .southEast: return .southWest
        case .southWest: return .southEast
        case .east: return .west
        case .west: return .east
        }
    }

    public func turnRight(degrees: Int = 90) -> CardinalDirection {
        assert(degrees >= 0)
        var degrees = degrees
        var direction = self
        while degrees >= 45 {
            switch direction {
            case .east: direction = .southEast
            case .southEast: direction = .south
            case .south: direction = .southWest
            case .southWest: direction = .west
            case .west: direction = .northWest
            case .northWest: direction = .north
            case .north: direction = .northEast
            case .northEast: direction = .east
            }
            degrees -= 45
        }
        return direction
    }

    public func turnLeft(degrees: Int = 90) -> CardinalDirection {
        return turnRight(degrees: 360 - degrees)
    }
}
