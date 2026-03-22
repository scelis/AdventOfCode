import Foundation

extension Dictionary {
    public mutating func getOrPut(key: Key, defaultValue: (() -> Value)) -> Value {
        if let value = self[key] {
            return value
        } else {
            let value = defaultValue()
            self[key] = value
            return value
        }
    }
}
