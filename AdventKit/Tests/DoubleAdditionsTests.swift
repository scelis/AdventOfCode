import Foundation
import Testing
@testable import AdventKit

@Suite struct DoubleAdditionsTests {
    @Test(
        arguments: [
            (3.1, false),
            (8.9, false),
            (-2.3, false),
            (5.0, true),
            (-1.0, true),
            (0.0, true)
        ]
    ) func isWholeNumber(number: Double, isWhole: Bool) {
        #expect(number.isWholeNumber == isWhole)
    }
}
