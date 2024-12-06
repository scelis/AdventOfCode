import AdventKit
import Foundation

struct Day15: Day {
    struct Sensor {
        var location: Coordinate2D
        var closestBeacon: Coordinate2D
    }

    func parseSensors() -> [Coordinate2D: Sensor] {
        var sensors: [Coordinate2D: Sensor] = [:]

        try! input().enumerateMatches(withPattern: "Sensor at x=(-?[0-9]+), y=(-?[0-9]+): closest beacon is at x=(-?[0-9]+), y=(-?[0-9]+)") { match in
            let sensor = Sensor(
                location: Coordinate2D(x: Int(match[1])!, y: Int(match[2])!),
                closestBeacon: Coordinate2D(x: Int(match[3])!, y: Int(match[4])!)
            )
            sensors[sensor.location] = sensor
        }

        return sensors
    }

    func run() async throws -> (Int, Int) {
        let sensors = parseSensors()
        async let p1 = part1(sensors: sensors)
        async let p2 = part2(sensors: sensors)
        return try await (p1, p2)
    }

    func part1(sensors: [Coordinate2D: Sensor]) async throws -> Int {
        let yPosition = 2000000

        var xPositions: Set<Int> = []
        for sensor in sensors.values {
            let distance = sensor.closestBeacon.manhattanDistance(from: sensor.location)

            let dy = abs(yPosition - sensor.location.y)
            if dy <= distance {
                let dx = distance - dy
                xPositions.formUnion((sensor.location.x - dx)...(sensor.location.x + dx))
            }

            if sensor.closestBeacon.y == yPosition {
                xPositions.remove(sensor.closestBeacon.x)
            }
        }

        return xPositions.count
    }

    func part2(sensors: [Coordinate2D: Sensor]) async throws -> Int {
        let validRange = 0...4000000

        func beaconValue(at location: Coordinate2D) -> Int? {
            guard validRange.contains(location.x), validRange.contains(location.y) else { return nil }

            for sensor in sensors.values {
                if location.manhattanDistance(from: sensor.location) <= sensor.location.manhattanDistance(from: sensor.closestBeacon) {
                    return nil
                }
            }

            return location.x * 4000000 + location.y
        }

        for sensor in sensors.values {
            let distance = abs(sensor.location.manhattanDistance(from: sensor.closestBeacon)) + 1

            var candidate = Coordinate2D(x: sensor.location.x, y: sensor.location.y - distance)
            while candidate.y != sensor.location.y {
                candidate = candidate.step(inDirection: .southEast)
                if let value = beaconValue(at: candidate) {
                    return value
                }
            }
            while candidate.x != sensor.location.x {
                candidate = candidate.step(inDirection: .southWest)
                if let value = beaconValue(at: candidate) {
                    return value
                }
            }
            while candidate.y != sensor.location.y {
                candidate = candidate.step(inDirection: .northWest)
                if let value = beaconValue(at: candidate) {
                    return value
                }
            }
            while candidate.x != sensor.location.x {
                candidate = candidate.step(inDirection: .northEast)
                if let value = beaconValue(at: candidate) {
                    return value
                }
            }
        }

        fatalError()
    }
}
