import Foundation
import XCTest
@testable import AdventKit


class GridGraphTests: XCTestCase {
    func testInvalidGraphThrows() {
        XCTAssertThrowsError(
            try GridGraph<IntNode>(data: [[1, 2, 3], [1, 2]], createNode: IntNode.init)
        )
    }

    func testWalk() throws {
        let graph = try GridGraph<IntNode>(data: intGraphData, createNode: IntNode.init)

        var counter = 0
        try graph.walk(.north, from: Coordinate2D(x: 1, y: 4)) { node, _ in
            switch counter {
            case 0:
                XCTAssertEqual(node.coordinate, Coordinate2D(x: 1, y: 3))
                XCTAssertEqual(node.value, 17)
            case 1:
                XCTAssertEqual(node.coordinate, Coordinate2D(x: 1, y: 2))
                XCTAssertEqual(node.value, 12)
            case 2:
                XCTAssertEqual(node.coordinate, Coordinate2D(x: 1, y: 1))
                XCTAssertEqual(node.value, 7)
            case 3:
                XCTAssertEqual(node.coordinate, Coordinate2D(x: 1, y: 0))
                XCTAssertEqual(node.value, 2)
            default:
                XCTFail()
            }

            counter += 1
        }
    }

    func testWalkAndStop() throws {
        let graph = try GridGraph<IntNode>(data: intGraphData, createNode: IntNode.init)

        var numSteps = 0
        try graph.walk(.north, from: Coordinate2D(x: 0, y: 4)) { _, stop in
            numSteps += 1
            if numSteps == 2 {
                stop = true
            }
        }

        XCTAssertEqual(numSteps, 2)
    }

    // MARK: Helpers

    private struct IntNode: GridGraphNode, Equatable, Hashable {
        var value: Int
        var coordinate: Coordinate2D = .zero
    }

    private var intGraphData: [[Int]] {
        return [
            [1, 2, 3, 4, 5],
            [6, 7, 8, 9, 10],
            [11, 12, 13, 14, 15],
            [16, 17, 18, 19, 20],
            [21, 22, 23, 24, 25],
        ]
    }
}
