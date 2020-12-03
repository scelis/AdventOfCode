import Foundation

infix operator ^^
extension Bool {
    public static func ^^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
