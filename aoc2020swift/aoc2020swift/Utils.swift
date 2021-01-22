//
// Created by Matt Burke on 1/14/21.
//

import Foundation

struct Utils {
    private init(){}

    static func readSample(inputName: String) -> String? {
        let file = FileManager.default
                .homeDirectoryForCurrentUser
                .appendingPathComponent("projects/misc/aoc-2020-swift/aoc2020swift/aoc2020swift/inputs/\(inputName).txt")
        return try? String(contentsOf: file)

    }

    static func readLines(_ inputName: String) -> [Substring]? {
        return readSample(inputName: inputName).map {
            $0.split(separator: "\n")
        }
    }

    static func splitLines(_ input: String) -> [String] {
        let lines = input.split(separator: "\n")
        return lines.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}

public extension String {
    func letter(at: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: at)]
    }
}
