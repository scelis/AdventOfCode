import Foundation

public typealias Point2D = (x: Double, y: Double)
public typealias Point3D = (x: Double, y: Double, z: Double)

public func rad2deg(_ number: Double) -> Double {
    return number * 180 / .pi
}

public func deg2rad(_ number: Double) -> Double {
    return number * .pi / 180
}

public func areaOfTriangle(a: Point2D, b: Point2D, c: Point2D) -> Double {
    let p1 = a.x * (b.y - c.y)
    let p2 = b.x * (c.y - a.y)
    let p3 = c.x * (a.y - b.y)
    return abs(p1 + p2 + p3) / 2
}

public func manhattanDistance(a: Point2D, b: Point2D) -> Double {
    return abs(a.x - b.x) + abs(a.y - b.y)
}

public func rotate(
    point: Point2D,
    around origin: Point2D,
    radians: Double)
    -> Point2D
{
    let s = sin(radians)
    let c = cos(radians)
    let x = c * (point.x - origin.x) - s * (point.y - origin.y) + origin.x
    let y = s * (point.x - origin.x) + c * (point.y - origin.y) + origin.y
    return (x, y)
}

public func rotate(
    point: Point2D,
    around origin: Point2D,
    degrees: Double)
    -> Point2D
{
    return rotate(point: point, around: origin, radians: deg2rad(degrees))
}
