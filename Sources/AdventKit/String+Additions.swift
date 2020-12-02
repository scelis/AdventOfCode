import Foundation

extension String {
    public var nsRange: NSRange {
        return NSMakeRange(0, (self as NSString).length)
    }

    public func substring(with range: NSRange) -> String {
        return (self as NSString).substring(with: range)
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

    public func enumerateMatches(
        withPattern pattern: String,
        patternOptions: NSRegularExpression.Options = [],
        matchingOptions: NSRegularExpression.MatchingOptions = [],
        using block: (String, [String?]) -> ()) throws
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
        using block: (String, [String?]) -> ()) throws
    {
        let numGroups = regex.numberOfCaptureGroups
        regex.enumerateMatches(in: self, options: options, range: nsRange, using: { result, _, _ in
            if let result = result {
                let match = substring(with: result.range)
                var groups = [String?]()
                for i in 0..<numGroups {
                    let groupRange = result.range(at: i + 1)
                    if groupRange.location == NSNotFound {
                        groups.append(nil)
                    } else {
                        groups.append(substring(with: groupRange))
                    }
                }
                block(match, groups)
            }
        })
    }

    public func firstMatchingGroups(
        withPattern pattern: String,
        patternOptions: NSRegularExpression.Options = [],
        matchingOptions: NSRegularExpression.MatchingOptions = []) throws
        -> [String?]?
    {
        var ret: [String?]?
        try enumerateMatches(
            withPattern: pattern,
            patternOptions: patternOptions,
            matchingOptions: matchingOptions,
            using: { _, groups in
                ret = groups
                return
            }
        )
        return ret
    }

    public func firstMatchingGroups(
        withRegularExpression regex: NSRegularExpression,
        options: NSRegularExpression.MatchingOptions = []) throws
        -> [String?]?
    {
        var ret: [String?]?
        try enumerateMatches(
            withRegularExpression: regex,
            options: options,
            using: { _, groups in
                ret = groups
                return
            }
        )
        return ret
    }
}
