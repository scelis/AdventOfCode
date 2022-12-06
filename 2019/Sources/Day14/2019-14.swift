import AdventKit
import Foundation

public class Day14: Day<Int, Int> {
    struct Chemical: Hashable {
        var name: String
        var amount: Int
    }

    struct Reaction: Hashable {
        var ingredients: [Chemical]
        var product: Chemical
    }

    func parse(component: String) -> Chemical {
        let parts = component.components(separatedBy: .whitespaces)
        return Chemical(name: parts[1], amount: Int(parts[0])!)
    }

    func parse(input: String) -> [Reaction] {
        var reactions: [Reaction] = []
        input.enumerateLines { line in
            let parts = line.components(separatedBy: "=>")
            let ingredientStrings = parts[0].trimmingCharacters(in: .whitespaces).components(separatedBy: ", ")
            let productString = parts[1].trimmingCharacters(in: .whitespaces)
            let ingredients = ingredientStrings.map({ parse(component: $0) })
            let product = parse(component: productString)
            reactions.append(Reaction(ingredients: ingredients, product: product))
        }

        return reactions
    }

    func requirements(for requirements: [String: Int], reactions: [Reaction]) -> Int {
        var reactionsByName: [String: Reaction] = [:]
        for reaction in reactions {
            reactionsByName[reaction.product.name] = reaction
        }

        var requirements = requirements
        var extras: [String: Int] = [:]
        while requirements.count != 1 || requirements["ORE"] == nil {
            let (name, amountNeeded) = requirements.first { (key, _) -> Bool in
                return key != "ORE"
            }!

            let reaction = reactionsByName[name]!
            let numReactionsNeeded = Int(ceil(Double(amountNeeded) / Double(reaction.product.amount)))
            let amountCreated = reaction.product.amount * numReactionsNeeded
            let extraProduct = amountCreated - amountNeeded
            requirements[name] = nil

            if extraProduct > 0 {
                extras[name] = (extras[name] ?? 0) + extraProduct
            }

            for ingredient in reaction.ingredients {
                var amountOfIngredientNeeded = (requirements[ingredient.name] ?? 0) + ingredient.amount * numReactionsNeeded
                if let extra = extras[ingredient.name] {
                    if extra > amountOfIngredientNeeded {
                        extras[ingredient.name] = extra - amountOfIngredientNeeded
                        amountOfIngredientNeeded = 0
                    } else {
                        amountOfIngredientNeeded = amountOfIngredientNeeded - extra
                        extras[ingredient.name] = nil
                    }
                }

                requirements[ingredient.name] = (amountOfIngredientNeeded > 0) ? amountOfIngredientNeeded : nil
            }
        }

        return requirements["ORE"]!
    }

    public override func part1() throws -> Int {
        let reactions = parse(input: input)
        return requirements(for: ["FUEL": 1], reactions: reactions)
    }

    public override func part2() throws -> Int {
        let reactions = parse(input: input)
        var mostFuel = 0
        var increment = 1000000000000
        while increment > 0 {
            let ore = requirements(for: ["FUEL": mostFuel + increment], reactions: reactions)
            if ore > 1000000000000 {
                increment = increment / 10
            } else {
                mostFuel += increment
            }
        }

        return mostFuel
    }
}
