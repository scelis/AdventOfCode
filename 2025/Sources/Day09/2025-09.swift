import AdventKit
import Algorithms
import Foundation

struct Day09: Day {
    struct Rectangle: Equatable, Hashable {
        var cornerA: Coordinate2D
        var cornerB: Coordinate2D
        var area: Int

        init(cornerA: Coordinate2D, cornerB: Coordinate2D) {
            self.cornerA = cornerA
            self.cornerB = cornerB
            self.area = abs(cornerA.x - cornerB.x + 1) * abs(cornerA.y - cornerB.y + 1)
        }

        var corners: Set<Coordinate2D> {
            [
                cornerA,
                cornerB,
                Coordinate2D(x: cornerA.x, y: cornerB.y),
                Coordinate2D(x: cornerB.x, y: cornerA.y),
            ]
        }

        var segments: Set<Segment> {
            let minX = min(cornerA.x, cornerB.x)
            let minY = min(cornerA.y, cornerB.y)
            let maxX = max(cornerA.x, cornerB.x)
            let maxY = max(cornerA.y, cornerB.y)
            return [
                Segment(pointA: Coordinate2D(x: minX, y: minY), pointB: Coordinate2D(x: maxX, y: minY)),
                Segment(pointA: Coordinate2D(x: maxX, y: minY), pointB: Coordinate2D(x: maxX, y: maxY)),
                Segment(pointA: Coordinate2D(x: maxX, y: maxY), pointB: Coordinate2D(x: minX, y: maxY)),
                Segment(pointA: Coordinate2D(x: minX, y: maxY), pointB: Coordinate2D(x: minX, y: minY)),
            ]
        }
    }

    struct Segment: Equatable, Hashable {
        var pointA: Coordinate2D
        var pointB: Coordinate2D
    }

    func run() async throws -> (Int, Int) {
        let coordinates = parseCoordinates()

        // Get a list of segments from the coordinates
        let segments: [Segment] = coordinates.enumerated().map { enumeration in
            let pointA = enumeration.element
            let pointB = coordinates[(enumeration.offset + 1) % coordinates.count]
            return Segment(pointA: pointA, pointB: pointB)
        }

        // Create a list of possible Rectangles, sorted by area
        let sortedRectangles = coordinates
            .combinations(ofCount: 2)
            .map { Rectangle(cornerA: $0[0], cornerB: $0[1]) }
            .sorted { $0.area > $1.area }

        // Part A: Find the largest rectangle
        let partA = sortedRectangles.first!.area

        // Part B: Find largest rectangle within the polygon
        let largestInteriorRectangle = sortedRectangles.first { isRectangle($0, within: segments) }
        let partB = largestInteriorRectangle!.area

        return (partA, partB)
    }

    func isRectangle(_ rectangle: Rectangle, within polygon: [Segment]) -> Bool {
        // All four corners must be within the polygon
        for corner in rectangle.corners {
            if !isPoint(corner, within: polygon) {
                return false
            }
        }

        // No segment can intersect the rectangle
        let rSegments = rectangle.segments
        for pSegment in polygon {
            for rSegment in rSegments {
                if doesSegment(rSegment, intersect: pSegment) {
                    return false
                }
            }
        }

        return true
    }

    func isPoint(_ point: Coordinate2D, within polygon: [Segment]) -> Bool {
        var intersections = 0
        for segment in polygon {
            if isPoint(point, on: segment) {
                return true
            }

            // We ray-cast to the right to count how many edges intersect this ray and use that to
            // determine if the point is within the polygon.
            if
                segment.pointA.y != segment.pointB.y,
                point.y >= min(segment.pointA.y, segment.pointB.y),
                point.y < max(segment.pointA.y, segment.pointB.y),
                point.x < segment.pointA.x
            {
                intersections += 1
            }
        }

        return intersections % 2 == 1
    }

    func isPoint(_ point: Coordinate2D, on segment: Segment) -> Bool {
        if
            point.x == segment.pointA.x,
            point.x == segment.pointB.x,
            point.y >= min(segment.pointA.y, segment.pointB.y),
            point.y <= max(segment.pointA.y, segment.pointB.y)
        {
            return true
        }

        if
            point.y == segment.pointA.y,
            point.y == segment.pointB.y,
            point.x >= min(segment.pointA.x, segment.pointB.x),
            point.x <= max(segment.pointA.x, segment.pointB.x)
        {
            return true
        }

        return false
    }
    
    func doesSegment(_ first: Segment, intersect second: Segment) -> Bool {
        if first.pointA.x == first.pointB.x, second.pointA.y == second.pointB.y {
            if
                first.pointA.x > min(second.pointA.x, second.pointB.x),
                first.pointA.x < max(second.pointA.x, second.pointB.x),
                second.pointA.y > min(first.pointA.y, first.pointB.y),
                second.pointA.y < max(first.pointA.y, first.pointB.y)
            {
                return true
            } else {
                return false
            }
        } else if first.pointA.y == first.pointB.y, second.pointA.x == second.pointB.x {
            if
                first.pointA.y > min(second.pointA.y, second.pointB.y),
                first.pointA.y < max(second.pointA.y, second.pointB.y),
                second.pointA.x > min(first.pointA.x, first.pointB.x),
                second.pointA.x < max(first.pointA.x, first.pointB.x)
            {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    func parseCoordinates() -> [Coordinate2D] {
        inputLines()
            .map { $0.components(separatedBy: ",").compactMap(Int.init) }
            .map { Coordinate2D(x: $0[0], y: $0[1])}
    }
}
