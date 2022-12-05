import AdventKit
import Foundation

class Day10: Day {
    lazy var asteroids: Set<Coordinate2D<Int>> = {
        var asteroids: Set<Coordinate2D<Int>> = []

        let array = inputLines.map { Array($0) }
        for y in 0..<array.count {
            for x in 0..<array[y].count {
                switch array[y][x] {
                case ".":
                    break
                case "#":
                    asteroids.insert(Coordinate2D(x: x, y: y))
                default:
                    fatalError()
                }
            }
        }

        return asteroids
    }()

    override func part1() -> Any {
        var bestAsteroid: Coordinate2D<Int>?
        var mostDetected = 0

        for candidateStation in asteroids {
            var visibleAsteroids = asteroids
            visibleAsteroids.remove(candidateStation)

            for asteroid1 in asteroids {
                for asteroid2 in asteroids {
                    if
                        asteroid1 != asteroid2,
                        visibleAsteroids.contains(asteroid1),
                        visibleAsteroids.contains(asteroid2),
                        areaOfTriangle(a: candidateStation.point2D(), b: asteroid1.point2D(), c: asteroid2.point2D()) == 0
                    {
                        if asteroid1.isBetween(a: candidateStation, b: asteroid2) {
                            visibleAsteroids.remove(asteroid2)
                        } else if asteroid2.isBetween(a: candidateStation, b: asteroid1) {
                            visibleAsteroids.remove(asteroid1)
                        }
                    }
                }
            }

            if visibleAsteroids.count > mostDetected {
                mostDetected = visibleAsteroids.count
                bestAsteroid = candidateStation
            }
        }

        return "\(bestAsteroid!) \(mostDetected)"
    }

    override func part2() -> Any {
        let station = Coordinate2D(x: 22, y: 28)
        let numAsteroids: Int = 200

        var asteroids = self.asteroids
        asteroids.remove(station)

        var degreesToCoordinates: [Int: [Coordinate2D<Int>]] = [:]
        for asteroid in asteroids {
            // Get the slope from the station to the asteroid in radians
            let radians = atan2(Double(asteroid.y - station.y), Double(asteroid.x - station.x))

            // Convert to degrees and distill down to the 0..<360 range
            var degrees = rad2deg(radians) + 90
            if degrees < 0 {
                degrees += 360
            }

            // Convert to an Int with 3 digits of decimal precision so that we can turn this
            // into a hash key
            let rounded = Int(round(degrees * 1000))

            if var coordinates = degreesToCoordinates[rounded] {
                coordinates.append(asteroid)
                degreesToCoordinates[rounded] = coordinates
            } else {
                degreesToCoordinates[rounded] = [asteroid]
            }
        }

        let allDegreesSorted = degreesToCoordinates.keys.sorted()
        var lastDestroyed: Coordinate2D<Int>?
        var numDestroyed = 0
        var degreesPointer = 0
        while numDestroyed < numAsteroids {
            var coordinates: [Coordinate2D<Int>] = []
            var degrees = 0

            while coordinates.isEmpty {
                degrees = allDegreesSorted[degreesPointer]
                coordinates = degreesToCoordinates[degrees] ?? []
                degreesPointer = (degreesPointer + 1) % allDegreesSorted.count
            }

            let closestCoordinate = coordinates.min { a, b -> Bool in
                return a.manhattanDistance(from: station) < b.manhattanDistance(from: station)
            }

            lastDestroyed = closestCoordinate
            coordinates = coordinates.filter { $0 != closestCoordinate }
            numDestroyed += 1
        }

        return "\(lastDestroyed!) \(lastDestroyed!.x * 100 + lastDestroyed!.y)"
    }
}
