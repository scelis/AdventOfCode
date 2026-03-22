import Foundation

public struct Pose: Equatable, Hashable {
    public var coordinate: Coordinate2D
    public var direction: Direction

    public init(coordinate: Coordinate2D, direction: Direction) {
        self.coordinate = coordinate
        self.direction = direction
    }
}

extension Pose {
    public func turningLeft() -> Pose {
        Pose(coordinate: coordinate, direction: direction.turnLeft())
    }

    public func turningRight() -> Pose {
        Pose(coordinate: coordinate, direction: direction.turnRight())
    }

    public func steppingForward() -> Pose {
        Pose(coordinate: coordinate.step(inDirection: direction), direction: direction)
    }
}
