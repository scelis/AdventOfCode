import AdventKit
import Foundation

struct Day22: Day {
    func run() async throws -> (Int, Int) {
        var secretNumberSum = 0
        var priceChangesToBananasPurchased: [[Int]: Int] = [:]
        for secretNumber in inputIntegers() {
            var previousSecretNumber = secretNumber
            var previousPrice = secretNumber % 10
            var recentPriceChanges: [Int] = []
            var priceChangesSeen: Set<[Int]> = []
            for i in 0..<2000 {
                let nextSecretNumber = generateNextSecretNumber(previousSecretNumber)
                let nextPrice = nextSecretNumber % 10
                recentPriceChanges.append(nextPrice - previousPrice)
                if i >= 4 {
                    recentPriceChanges.removeFirst()
                }
                if i >= 3 && !priceChangesSeen.contains(recentPriceChanges) {
                    priceChangesSeen.insert(recentPriceChanges)
                    priceChangesToBananasPurchased[recentPriceChanges, default: 0] += nextPrice
                }
                previousSecretNumber = nextSecretNumber
                previousPrice = nextPrice
            }
            secretNumberSum += previousSecretNumber
        }
        return (secretNumberSum, priceChangesToBananasPurchased.values.max()!)
    }

    func generateNextSecretNumber(_ number: Int) -> Int {
        var secret = number
        secret = ((secret * 64) ^ secret) % 16777216
        secret = ((secret / 32) ^ secret) % 16777216
        secret = ((secret * 2048) ^ secret) % 16777216
        return secret
    }
}
