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
