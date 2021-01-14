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
        for i in 0...(match.numberOfRanges-1) {
            let r = Range(match.range(at: i), in: target)!
            groups.append(String(target[r]))
        }

        return SimpleRegex(groups: groups)
    }
}
