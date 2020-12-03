import Foundation

public struct Coordinate3D<T: SignedNumeric & Comparable & Hashable & BinaryInteger>: Hashable {
    public var x: T
    public var y: T
    public var z: T

    public init(x: T, y: T, z: T) {
        self.x = x
        self.y = y
        self.z = z
    }

    public static func == (lhs: Coordinate3D, rhs: Coordinate3D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }

    public func manhattanDistance(from: Coordinate3D) -> T {
        return abs(x - from.x) + abs(y - from.y) + abs(z - from.z)
    }

    public func isBetween(a: Coordinate3D, b: Coordinate3D) -> Bool {
        let x1 = (a.x <= self.x && self.x <= b.x)
        let x2 = (a.x >= self.x && self.x >= b.x)
        let y1 = (a.y <= self.y && self.y <= b.y)
        let y2 = (a.y >= self.y && self.y >= b.y)
        let z1 = (a.z <= self.z && self.z <= b.z)
        let z2 = (a.z >= self.z && self.z >= b.z)
        return (x1 || x2) && (y1 || y2) && (z1 || z2)
    }
}
