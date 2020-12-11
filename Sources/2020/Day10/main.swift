import AdventKit
import Algorithms
import Foundation

class Day10: Day {
    override func part1() -> String {
        var differences: [Int: Int] = [:]
        var integers = inputIntegers.sorted()
        integers.append(integers.last! + 3)

        integers
            .enumerated()
            .forEach { (index, element) in
                let previous = (index > 0) ? integers[index - 1] : 0
                let diff = element - previous
                differences[diff] = (differences[diff] ?? 0) + 1
            }

        return "\(differences[1]! * differences[3]!)"
    }

    override func part2() -> String {
        var integers = inputIntegers.sorted()
        integers.append(integers.last! + 3)
        return ""
    }
}

let example1 = """
16
10
15
5
1
11
7
19
6
12
4
"""

assert(Day10(input: example1).part1() == "\(7 * 5)")

let example2 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""

assert(Day10(input: example2).part1() == "\(22 * 10)")

Day10().run()
