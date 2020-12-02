import Foundation

extension String {
    public var nsRange: NSRange {
        return NSMakeRange(0, (self as NSString).length)
    }

    public func substring(with range: NSRange) -> String {
        return (self as NSString).substring(with: range)
    }
}
