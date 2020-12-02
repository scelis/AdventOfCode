import Foundation

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
