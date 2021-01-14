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
        let count = password.filter { $0 == letter }.count
        return count >= min && count <= max;
    }

    func evaluate2(password: String) -> Bool {
        let letter0 = password.letter(at: min-1);
        let letter1 = password.letter(at: max-1);
        return letter0 != letter1 && (letter0 == letter || letter1 == letter)
    }
}

struct PasswordTest: Equatable {
    var policy: PasswordPolicy
    var password: String

    func isValid() -> Bool {
        policy.evaluate(password: password)
    }

    func isValid2() -> Bool {
        policy.evaluate2(password: password)
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

       let valid2Count = tests.filter { $0.isValid2() }.count
       print("There are \(valid2Count) valid passwords under the new rules")
    }
}


