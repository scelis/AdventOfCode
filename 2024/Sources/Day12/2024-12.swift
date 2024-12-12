import AdventKit
import Foundation

struct Day12: Day {
    struct Region {
        var area: Int
        var perimeter: Int
        var corners: Int
    }

    func run() async throws -> (Int, Int) {
        let regions = findRegions()
        let p1 = regions.reduce(0) { $0 + $1.area * $1.perimeter }
        let p2 = regions.reduce(0) { $0 + $1.area * $1.corners }
        return (p1, p2)
    }

    func findRegions() -> [Region] {
        let map = inputCharacterArrays()
        var newRegionCoordinatesToCheck: Set<Coordinate2D> = [.zero]
        var coordinatesChecked: Set<Coordinate2D> = []
        var regions: Array<Region> = []
        while let newRegionCoordinate = newRegionCoordinatesToCheck.popFirst() {
            guard !coordinatesChecked.contains(newRegionCoordinate) else { continue }
            let character = map[newRegionCoordinate]
            var currentRegion: Region = Region(area: 0, perimeter: 0, corners: 0)
            var sameRegionCoordinatesToCheck: Set<Coordinate2D> = [newRegionCoordinate]
            while let coordinate = sameRegionCoordinatesToCheck.popFirst() {
                coordinatesChecked.insert(coordinate)
                currentRegion.area += 1

                for neighbor in coordinate.neighboringCoordinates() {
                    let neighborCharacter = map[safe: neighbor]
                    if neighborCharacter != character {
                        currentRegion.perimeter += 1
                    }
                    if neighborCharacter != nil && !coordinatesChecked.contains(neighbor) {
                        if neighborCharacter == character {
                            sameRegionCoordinatesToCheck.insert(neighbor)
                        } else {
                            newRegionCoordinatesToCheck.insert(neighbor)
                        }
                    }
                }

                let possibleCorners: [(Direction, Direction)] = [(.up, .left), (.up, .right), (.down, .left), (.down, .right)]
                for corner in possibleCorners {
                    if
                        map[safe: coordinate.step(inDirection: corner.0)] != character,
                        map[safe: coordinate.step(inDirection: corner.1)] != character
                    {
                        currentRegion.corners += 1
                    } else if
                        map[safe: coordinate.step(inDirection: corner.0)] == character,
                        map[safe: coordinate.step(inDirection: corner.1)] == character,
                        map[safe: coordinate.step(inDirection: corner.0).step(inDirection: corner.1)] != character
                    {
                        currentRegion.corners += 1
                    }
                }
            }
            regions.append(currentRegion)
        }

        return regions
    }
}
