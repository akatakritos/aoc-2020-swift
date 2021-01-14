//
// Created by Matt Burke on 1/14/21.
//

import Foundation

struct Utils {
    private init(){}

    static func readLines(_ inputName: String) -> [Substring]? {
        let file = FileManager.default
                .homeDirectoryForCurrentUser
                .appendingPathComponent("projects/misc/aoc-2020-swift/aoc2020swift/aoc2020swift/inputs/\(inputName).txt")
        do {
            let text = try String(contentsOf: file)
            return text.split(separator: "\n")
        }
        catch {
            print("\(error)")
            return nil
        }

    }
}

public extension String {
    public func letter(at: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: at)]
    }
}