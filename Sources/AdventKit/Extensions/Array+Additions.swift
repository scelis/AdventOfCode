import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    public func removing(at: Int) -> Array<Element> {
        var array = self
        array.remove(at: at)
        return array
    }
}

extension Array<String> {
    public func toFilePath() -> String {
        return "/" + joined(separator: "/")
    }
}

extension Array where Element: Collection, Element.Index == Int {
    public subscript (coordinate: Coordinate2D) -> Element.Element {
        self[coordinate.y][coordinate.x]
    }

    public subscript (safe coordinate: Coordinate2D) -> Element.Element? {
        guard
            coordinate.y >= 0,
            coordinate.y < count,
            coordinate.x >= 0,
            coordinate.x < self[coordinate.y].count
        else {
            return nil
        }

        return self[coordinate.y][coordinate.x]
    }
}
