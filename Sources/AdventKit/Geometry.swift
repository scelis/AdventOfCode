import Foundation

public typealias Point2D = (x: Double, y: Double)

public func rad2deg(_ number: Double) -> Double {
    return number * 180 / .pi
}

public func deg2rad(_ number: Double) -> Double {
    return number * .pi / 180
}

public func areaOfTriangle<T>(a: Coordinate2D<T>, b: Coordinate2D<T>, c: Coordinate2D<T>) -> Double {
    let p1 = Double(a.x) * Double(b.y - c.y)
    let p2 = Double(b.x) * Double(c.y - a.y)
    let p3 = Double(c.x) * Double(a.y - b.y)
    return abs(Double(p1 + p2 + p3)) / 2
}

public func manhattanDistance(pointA: Point2D, pointB: Point2D) -> Double {
    return abs(pointA.x - pointB.x) + abs(pointA.y - pointB.y)
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
