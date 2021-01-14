//
// Created by Matt Burke on 1/14/21.
//

import Foundation

struct Puzzle01 {
    private init() {}

    static func findEntries(_ expenses: [Int], summingTo: Int) -> (Int, Int)? {
        for a in expenses {
            for b in expenses {
                if a + b == summingTo {
                    return (a, b);
                }
            }
        }

        return nil;
    }

    static func run() {
        let input = Utils.readLines("puzzle-01")!
        let entries = input.map { Int($0)! }
        let (a, b) = findEntries(entries, summingTo: 2020)!;
        print("\(a) * \(b) = \(a * b)")
    }



}
