import Foundation

extension Range<Int> {
    public func binaryFirstIndex(where block: (Element) -> Bool) -> Int? {
        var l = startIndex
        var r = endIndex
        var foundMatch = false

        while l < r {
            let m = (l + r) / 2
            if block(self[m]) {
                foundMatch = true
                r = m
            } else {
                l = m + 1
            }
        }

        return foundMatch ? l : nil
    }

    public func binaryLastIndex(where block: (Element) -> Bool) -> Int? {
        var l = startIndex
        var r = endIndex
        var foundMatch = false

        while l < r {
            let m = (l + r) / 2
            if block(self[m]) {
                foundMatch = true
                l = m + 1
            } else {
                r = m
            }
        }

        return foundMatch ? r - 1 : nil
    }
}
