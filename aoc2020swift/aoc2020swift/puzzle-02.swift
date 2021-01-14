//
// Created by Matt Burke on 1/14/21.
//

import Foundation



struct PasswordPolicy: Equatable {
    var letter: Character
    var min: Int
    var max: Int

    static func parse<T: StringProtocol>(_ s: T) -> PasswordPolicy? {
        guard let match = SimpleRegex.match(pattern: "^(\\d+)-(\\d+) ([a-z])$", target: s) else {
            return nil;
        }

        let min = Int(match.groups[1])!
        let max = Int(match.groups[2])!
        let letter = match.groups[3];

        return PasswordPolicy(
                letter: letter[letter.index(letter.startIndex, offsetBy: 0)],
                min: min,
                max: max);

    }

    func evaluate(password: String) -> Bool {
        var count = password.filter { $0 == letter }.count
        return count >= min && count <= max;
    }
}

struct PasswordTest: Equatable {
    var policy: PasswordPolicy
    var password: String

    func isValid() -> Bool {
        policy.evaluate(password: password)
    }

    static func parse<T: StringProtocol>(_ s: T) -> PasswordTest? {
        let parts = s.split(separator: ":")
        guard let policy = PasswordPolicy.parse(parts[0].trimmingCharacters(in: .whitespacesAndNewlines)) else {
            return nil
        }

        let password = String(parts[1].trimmingCharacters(in: .whitespacesAndNewlines));

        return PasswordTest(policy: policy, password: password)
    }
}

struct Puzzle02 {
    private init() {}

   static func run() {
        let input = Utils.readLines("puzzle-02")!
        let tests = input.map { PasswordTest.parse($0)! }

        let validCount = tests.filter { $0.isValid() }.count
        print("There are \(validCount) valid passwords in the set")
    }
}


