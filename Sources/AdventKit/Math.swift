import Foundation

public enum Math {
    public static func rad2deg(_ number: Double) -> Double {
        return number * 180 / .pi
    }

    public static func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
}
