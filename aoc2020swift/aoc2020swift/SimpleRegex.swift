//
// Created by Matt Burke on 1/14/21.
//

import Foundation

struct SimpleRegex {

    let groups: [String];

    var match: String {
        get { groups[0] }
    }

    static func match<T: StringProtocol>(pattern: String, target: T) -> SimpleRegex? {
        let range = NSRange(location: 0, length: target.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: String(target), range: range) else {
            return nil
        }

        var groups: [String] = [];
        for i in 0..<match.numberOfRanges {
            let nsRange = match.range(at: i)

            if (nsRange.location == NSNotFound) {
                groups.append("")
            } else {
                let r = Range(nsRange, in: target)!
                groups.append(String(target[r]))
            }
        }

        return SimpleRegex(groups: groups)
    }

    static func isMatch<T: StringProtocol>(pattern: String, target: T) -> Bool {
        let range = NSRange(location: 0, length: target.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        let match = regex.firstMatch(in: String(target), range: range)
        return match != nil
    }
}
