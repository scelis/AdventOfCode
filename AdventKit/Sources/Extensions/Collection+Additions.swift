import Foundation

extension Collection {
    public func anySatisfy(
        where predicate: (Element) throws -> Bool
    ) rethrows -> Bool {
        try firstIndex(where: predicate) != nil
    }
}
