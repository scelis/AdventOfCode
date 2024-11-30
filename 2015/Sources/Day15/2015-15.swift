import AdventKit
import Foundation

struct Day15: Day {

    // MARK: Structures

    struct Ingredient {
        var name: String
        var capacity: Int
        var durability: Int
        var flavor: Int
        var texture: Int
        var calories: Int
    }

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        let ingredients = parseIngredients()
        async let p1 = part1(ingredients: ingredients)
        async let p2 = part2(ingredients: ingredients)
        return try await (p1, p2)
    }

    func part1(ingredients: [Ingredient]) async throws -> Int {
        var best = 0
        for i in 1...97 {
            for j in 1...(98 - i) {
                for k in 1...(99 - i - j) {
                    let l = 100 - i - j - k
                    let capacity = max(ingredients[0].capacity * i + ingredients[1].capacity * j + ingredients[2].capacity * k + ingredients[3].capacity * l, 0)
                    let durability = max(ingredients[0].durability * i + ingredients[1].durability * j + ingredients[2].durability * k + ingredients[3].durability * l, 0)
                    let flavor = max(ingredients[0].flavor * i + ingredients[1].flavor * j + ingredients[2].flavor * k + ingredients[3].flavor * l, 0)
                    let texture = max(ingredients[0].texture * i + ingredients[1].texture * j + ingredients[2].texture * k + ingredients[3].texture * l, 0)
                    let score = capacity * durability * flavor * texture
                    best = max(score, best)
                }
            }
        }

        return best
    }

    func part2(ingredients: [Ingredient]) async throws -> Int {
        var best = 0
        for i in 1...97 {
            for j in 1...(98 - i) {
                for k in 1...(99 - i - j) {
                    let l = 100 - i - j - k
                    let calories = max(ingredients[0].calories * i + ingredients[1].calories * j + ingredients[2].calories * k + ingredients[3].calories * l, 0)
                    if calories == 500 {
                        let capacity = max(ingredients[0].capacity * i + ingredients[1].capacity * j + ingredients[2].capacity * k + ingredients[3].capacity * l, 0)
                        let durability = max(ingredients[0].durability * i + ingredients[1].durability * j + ingredients[2].durability * k + ingredients[3].durability * l, 0)
                        let flavor = max(ingredients[0].flavor * i + ingredients[1].flavor * j + ingredients[2].flavor * k + ingredients[3].flavor * l, 0)
                        let texture = max(ingredients[0].texture * i + ingredients[1].texture * j + ingredients[2].texture * k + ingredients[3].texture * l, 0)
                        let score = capacity * durability * flavor * texture
                        best = max(score, best)
                    }
                }
            }
        }

        return best
    }

    // MARK: Parsing

    func parseIngredients() -> [Ingredient] {
        let regex = #/^(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/#

        return inputLines().map { line in
            let match = line.firstMatch(of: regex)!
            return Ingredient(
                name: String(match.1),
                capacity: Int(match.2)!,
                durability: Int(match.3)!,
                flavor: Int(match.4)!,
                texture: Int(match.5)!,
                calories: Int(match.6)!
            )
        }
    }
}
