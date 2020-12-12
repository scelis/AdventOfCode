import Foundation

public struct Coordinate2D<T: SignedNumeric & Comparable & Hashable & BinaryInteger>: Hashable {
    public var x: T
    public var y: T

    public init(x: T, y: T) {
        self.x = x
        self.y = y
    }

    public static func == (lhs: Coordinate2D, rhs: Coordinate2D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }

    public func manhattanDistance(from: Coordinate2D) -> T {
        return abs(x - from.x) + abs(y - from.y)
    }

    public func isBetween(a: Coordinate2D, b: Coordinate2D) -> Bool {
        let x1 = (a.x <= self.x && self.x <= b.x)
        let x2 = (a.x >= self.x && self.x >= b.x)
        let y1 = (a.y <= self.y && self.y <= b.y)
        let y2 = (a.y >= self.y && self.y >= b.y)
        return (x1 || x2) && (y1 || y2)
    }
}

extension Collection where Element == Coordinate2D<Int> {
    public var top: Coordinate2D<Int>? {
        return self.min { a, b -> Bool in
            return a.y < b.y
        }
    }

    public var bottom: Coordinate2D<Int>? {
        return self.max { a, b -> Bool in
            return a.y < b.y
        }
    }

    public var left: Coordinate2D<Int>? {
        return self.min { a, b -> Bool in
            return a.x < b.x
        }
    }

    public var right: Coordinate2D<Int>? {
        return self.max { a, b -> Bool in
            return a.x < b.x
        }
    }
}

extension Coordinate2D where T == Int {
    public func step(inCardinalDirection direction: CardinalDirection, distance: Int = 1) -> Coordinate2D {
        return Coordinate2D(x: x + direction.dx * distance, y: y + direction.dy * distance)
    }

    public func step(inDirection direction: Direction, distance: T = 1) -> Coordinate2D {
        return Coordinate2D(x: x + direction.dx * distance, y: y + direction.dy * distance)
    }

    public func rotate(around origin: Coordinate2D<Int>, degrees: Int) -> Coordinate2D<Int> {
        let tmp = AdventKit.rotate(
            point: (Double(self.x), Double(self.y)),
            around: (Double(origin.x), Double(origin.y)),
            degrees: Double(degrees)
        )
        return Coordinate2D(x: Int(round(tmp.x)), y: Int(round(tmp.y)))
    }
}
