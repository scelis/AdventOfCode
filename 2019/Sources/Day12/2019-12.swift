import AdventKit
import Foundation

public class Day12: Day<Int, Int> {
    class Moon {
        var position: Coordinate3D
        var velocity: Coordinate3D

        init(
            position: Coordinate3D,
            velocity: Coordinate3D = Coordinate3D(x: 0, y: 0, z: 0))
        {
            self.position = position
            self.velocity = velocity
        }
    }

    public override func part1() throws -> Int {
        return part1(
            a: Coordinate3D(x: 16, y: -11, z: 2),
            b: Coordinate3D(x: 0, y: -4, z: 7),
            c: Coordinate3D(x: 6, y: 4, z: -10),
            d: Coordinate3D(x: -3, y: -2, z: -4),
            steps: 1000
        )
    }

    func part1(
        a: Coordinate3D,
        b: Coordinate3D,
        c: Coordinate3D,
        d: Coordinate3D,
        steps: Int)
        -> Int
    {
        var moons: [Moon] = []
        moons.append(Moon(position: a))
        moons.append(Moon(position: b))
        moons.append(Moon(position: c))
        moons.append(Moon(position: d))

        for _ in 0..<steps {
            for i in 0..<moons.count {
                for j in i+1..<moons.count {
                    let moon1 = moons[i]
                    let moon2 = moons[j]

                    if moon1.position.x < moon2.position.x {
                        moon1.velocity.x += 1
                        moon2.velocity.x -= 1
                    } else if moon1.position.x > moon2.position.x {
                        moon1.velocity.x -= 1
                        moon2.velocity.x += 1
                    }
                    if moon1.position.y < moon2.position.y {
                        moon1.velocity.y += 1
                        moon2.velocity.y -= 1
                    } else if moon1.position.y > moon2.position.y {
                        moon1.velocity.y -= 1
                        moon2.velocity.y += 1
                    }
                    if moon1.position.z < moon2.position.z {
                        moon1.velocity.z += 1
                        moon2.velocity.z -= 1
                    } else if moon1.position.z > moon2.position.z {
                        moon1.velocity.z -= 1
                        moon2.velocity.z += 1
                    }
                }
            }

            for moon in moons {
                moon.position.x += moon.velocity.x
                moon.position.y += moon.velocity.y
                moon.position.z += moon.velocity.z
            }
        }

        var energy = 0
        for moon in moons {
            let potentialEnergy = abs(moon.position.x) + abs(moon.position.y) + abs(moon.position.z)
            let kineticEnergy = abs(moon.velocity.x) + abs(moon.velocity.y) + abs(moon.velocity.z)
            energy = energy + (potentialEnergy * kineticEnergy)
        }

        return energy
    }

    public override func part2() throws -> Int {
        return part2(
            a: Coordinate3D(x: 16, y: -11, z: 2),
            b: Coordinate3D(x: 0, y: -4, z: 7),
            c: Coordinate3D(x: 6, y: 4, z: -10),
            d: Coordinate3D(x: -3, y: -2, z: -4)
        )
    }

    func part2(
        a: Coordinate3D,
        b: Coordinate3D,
        c: Coordinate3D,
        d: Coordinate3D)
        -> Int
    {
        var moons: [Moon] = []
        moons.append(Moon(position: a))
        moons.append(Moon(position: b))
        moons.append(Moon(position: c))
        moons.append(Moon(position: d))

        var counts: [Int] = []
        outer: for i in 0..<3 {
            var steps = 0
            var seen: Set<[Int]> = []
            while true {
                let state: [Int]
                if i == 0 {
                    state = Array(moons.map({ [$0.position.x, $0.velocity.x] }).joined())
                } else if i == 1 {
                    state = Array(moons.map({ [$0.position.y, $0.velocity.y] }).joined())
                } else {
                    state = Array(moons.map({ [$0.position.z, $0.velocity.z] }).joined())
                }

                if seen.contains(state) {
                    counts.append(steps)
                    continue outer
                } else {
                    seen.insert(state)
                }

                for j in 0..<moons.count {
                    for k in j+1..<moons.count {
                        let moon1 = moons[j]
                        let moon2 = moons[k]

                        if i == 0 {
                            if moon1.position.x < moon2.position.x {
                                moon1.velocity.x += 1
                                moon2.velocity.x -= 1
                            } else if moon1.position.x > moon2.position.x {
                                moon1.velocity.x -= 1
                                moon2.velocity.x += 1
                            }
                        } else if i == 1 {
                            if moon1.position.y < moon2.position.y {
                                moon1.velocity.y += 1
                                moon2.velocity.y -= 1
                            } else if moon1.position.y > moon2.position.y {
                                moon1.velocity.y -= 1
                                moon2.velocity.y += 1
                            }
                        } else {
                            if moon1.position.z < moon2.position.z {
                                moon1.velocity.z += 1
                                moon2.velocity.z -= 1
                            } else if moon1.position.z > moon2.position.z {
                                moon1.velocity.z -= 1
                                moon2.velocity.z += 1
                            }
                        }
                    }
                }

                for moon in moons {
                    if i == 0 {
                        moon.position.x += moon.velocity.x
                    } else if i == 1 {
                        moon.position.y += moon.velocity.y
                    } else {
                        moon.position.z += moon.velocity.z
                    }
                }

                steps += 1
            }
        }

        return counts.leastCommonMultiple
    }
}
