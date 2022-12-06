import Foundation

extension String {
    public func enumerateMatches(
        withPattern pattern: String,
        patternOptions: NSRegularExpression.Options = [],
        matchingOptions: NSRegularExpression.MatchingOptions = [],
        using block: ([String]) -> ()) throws
    {
        let regex = try NSRegularExpression(pattern: pattern, options: patternOptions)
        return try enumerateMatches(
            withRegularExpression: regex,
            options: matchingOptions,
            using: block
        )
    }

    public func enumerateMatches(
        withRegularExpression regex: NSRegularExpression,
        options: NSRegularExpression.MatchingOptions = [],
        using block: ([String]) -> ()) throws
    {
        let numGroups = regex.numberOfCaptureGroups
        regex.enumerateMatches(in: self, options: options, range: nsRange, using: { result, _, _ in
            if let result = result {
                var groups: [String] = []
                groups.append(substring(with: result.range))
                for i in 0..<numGroups {
                    let groupRange = result.range(at: i + 1)
                    if groupRange.location == NSNotFound {
                        groups.append("")
                    } else {
                        groups.append(substring(with: groupRange))
                    }
                }
                block(groups)
            }
        })
    }

    public func firstMatch(
        withPattern pattern: String,
        patternOptions: NSRegularExpression.Options = [],
        matchingOptions: NSRegularExpression.MatchingOptions = []) throws
        -> [String]?
    {
        var ret: [String]?
        try enumerateMatches(
            withPattern: pattern,
            patternOptions: patternOptions,
            matchingOptions: matchingOptions,
            using: { groups in
                ret = groups
                return
            }
        )
        return ret
    }

    public func firstMatch(
        withRegularExpression regex: NSRegularExpression,
        options: NSRegularExpression.MatchingOptions = []) throws
        -> [String]?
    {
        var ret: [String]?
        try enumerateMatches(
            withRegularExpression: regex,
            options: options,
            using: { groups in
                ret = groups
                return
            }
        )
        return ret
    }
}
