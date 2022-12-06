import Foundation

public struct Coordinate2D: Equatable, Hashable {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public func manhattanDistance(from: Coordinate2D) -> Int {
        return abs(from.x - x) + abs(from.y - y)
    }

    public func isBetween(a: Coordinate2D, b: Coordinate2D) -> Bool {
        let x1 = (a.x <= self.x && self.x <= b.x)
        let x2 = (a.x >= self.x && self.x >= b.x)
        let y1 = (a.y <= self.y && self.y <= b.y)
        let y2 = (a.y >= self.y && self.y >= b.y)
        return (x1 || x2) && (y1 || y2)
    }

    public func rotate(
        around origin: Coordinate2D,
        radians: Double
    ) -> Coordinate2D {
        let s = sin(radians)
        let c = cos(radians)
        let newX = c * Double(x - origin.x) - s * Double(y - origin.y) + Double(origin.x)
        let newY = s * Double(x - origin.x) + c * Double(y - origin.y) + Double(origin.y)
        return Coordinate2D(x: Int(round(newX)), y: Int(round(newY)))
    }

    public func rotate(
        around origin: Coordinate2D,
        degrees: Int
    ) -> Coordinate2D {
        return rotate(around: origin, radians: Math.deg2rad(Double(degrees)))
    }

    public func step(inCardinalDirection direction: CardinalDirection, distance: Int = 1) -> Coordinate2D {
        return Coordinate2D(x: x + direction.dx * distance, y: y + direction.dy * distance)
    }

    public func step(inDirection direction: Direction, distance: Int = 1) -> Coordinate2D {
        return Coordinate2D(x: x + direction.dx * distance, y: y + direction.dy * distance)
    }

    public func neighboringCoordinates() -> Set<Coordinate2D> {
        let neighbors = CardinalDirection.mainDirections.map { direction in
            self.step(inCardinalDirection: direction)
        }

        return Set(neighbors)
    }
}

extension Collection where Element == Coordinate2D {
    public var top: Coordinate2D? {
        return self.min { a, b -> Bool in
            return a.y < b.y
        }
    }

    public var bottom: Coordinate2D? {
        return self.max { a, b -> Bool in
            return a.y < b.y
        }
    }

    public var left: Coordinate2D? {
        return self.min { a, b -> Bool in
            return a.x < b.x
        }
    }

    public var right: Coordinate2D? {
        return self.max { a, b -> Bool in
            return a.x < b.x
        }
    }
}
