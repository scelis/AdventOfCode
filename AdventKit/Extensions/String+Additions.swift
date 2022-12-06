import Foundation

extension String {
    public subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    public func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }

    public func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    public subscript (r: Range<Int>) -> String {
        let range = Range(
            uncheckedBounds: (
                lower: max(0, min(count, r.lowerBound)),
                upper: min(count, max(0, r.upperBound))
            )
        )
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

    public func enumerateLines(using block: (String) -> ()) {
        let lines = self.components(separatedBy: .newlines)
        for line in lines {
            let line = line.trimmingCharacters(in: .whitespaces)
            if !line.isEmpty {
                block(line)
            }
        }
    }
}
