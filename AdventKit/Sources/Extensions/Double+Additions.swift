import Foundation

extension Double {
    public var isWholeNumber: Bool {
        truncatingRemainder(dividingBy: 1) == 0
    }
}
