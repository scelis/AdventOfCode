import Foundation

public enum Geometry {
    public static func areaOfTriangle(_ a: Coordinate2D, _ b: Coordinate2D, _ c: Coordinate2D) -> Double {
        let p1 = a.x * (b.y - c.y)
        let p2 = b.x * (c.y - a.y)
        let p3 = c.x * (a.y - b.y)
        return Double(abs(p1 + p2 + p3)) / Double(2)
    }
}
