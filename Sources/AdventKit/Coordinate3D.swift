import Foundation

public struct Coordinate3D: Equatable, Hashable, Sendable {
    public var x: Int
    public var y: Int
    public var z: Int

    public static let zero = Coordinate3D(x: 0, y: 0, z: 0)

    public init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    public func manhattanDistance(from: Coordinate3D) -> Int {
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
