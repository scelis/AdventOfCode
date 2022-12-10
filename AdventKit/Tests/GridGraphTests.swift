import Foundation
import XCTest
@testable import AdventKit


class GridGraphTests: XCTestCase {
    struct IntNode: GridGraphNode, Equatable, ExpressibleByIntegerLiteral, Hashable {
        var value: Int

        init(integerLiteral: Int) {
            self.value = integerLiteral
        }
    }

    var intGraphData: [[IntNode]] {
        return [
            [1, 2, 3, 4, 5],
            [6, 7, 8, 9, 10],
            [11, 12, 13, 14, 15],
            [16, 17, 18, 19, 20],
            [21, 22, 23, 24, 25],
        ]
    }

    func testInvalidGraphThrows() {
        XCTAssertThrowsError(try GridGraph<IntNode>(data: [[1, 2, 3], [1, 2]]))
    }

    func testWalk() throws {
        let graph = try GridGraph(data: intGraphData)

        var counter = 0
        graph.walk(.north, from: Coordinate2D(x: 1, y: 4)) { node, coordinate, _ in
            switch counter {
            case 0:
                XCTAssertEqual(coordinate, Coordinate2D(x: 1, y: 3))
                XCTAssertEqual(node, 17)
            case 1:
                XCTAssertEqual(coordinate, Coordinate2D(x: 1, y: 2))
                XCTAssertEqual(node, 12)
            case 2:
                XCTAssertEqual(coordinate, Coordinate2D(x: 1, y: 1))
                XCTAssertEqual(node, 7)
            case 3:
                XCTAssertEqual(coordinate, Coordinate2D(x: 1, y: 0))
                XCTAssertEqual(node, 2)
            default:
                XCTFail()
            }

            counter += 1
        }
    }

    func testWalkAndStop() throws {
        let graph = try GridGraph(data: intGraphData)

        var numSteps = 0
        graph.walk(.north, from: Coordinate2D(x: 0, y: 4)) { _, _, stop in
            numSteps += 1
            if numSteps == 2 {
                stop = true
            }
        }

        XCTAssertEqual(numSteps, 2)
    }
}
