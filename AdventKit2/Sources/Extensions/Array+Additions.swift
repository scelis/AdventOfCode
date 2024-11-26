import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

extension Array<String> {
    public func toFilePath() -> String {
        return "/" + joined(separator: "/")
    }
}
