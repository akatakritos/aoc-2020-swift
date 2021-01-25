//
//  puzzle-06.swift
//  aoc2020swift
//
//  Created by Matt Burke on 1/24/21.
//

import Foundation

struct CustomsGroup {
    let answers: Dictionary<Character, Int>;
    let memberCount: Int

    static func parse(_ s: String) -> CustomsGroup {
        var answers = Dictionary<Character, Int>()
        let people = s.split(separator: "\n")
        let memberCount = people.count

        for personsAnswers in people {
            for answered in personsAnswers {
                if let count = answers[answered] {
                    answers[answered] = count + 1
                } else {
                    answers[answered] = 1
                }
            }
        }

        return CustomsGroup(answers: answers, memberCount: memberCount)
    }

    func countUniqueAnswers() -> Int {
        answers.count
    }

    func countAllAnswered() -> Int {
        answers.keys.lazy
            .filter { key in answers[key] == memberCount }
            .count
    }

    func countWho(answered: Character) -> Int {
        if let count = answers[answered] {
            return count
        }

        return 0
    }
}

struct GroupList {
    let groups: [CustomsGroup]

    static func parse(_ s: String) -> GroupList{
        let groups = s.components(separatedBy: "\n\n")
            .map { CustomsGroup.parse($0) }

        return GroupList(groups: groups)
    }

    func sumCountUniqueAnswers() -> Int {
        groups.lazy
            .map { $0.countUniqueAnswers() }
            .reduce(0, +)
    }

    func sumCountAllAnswered() -> Int {
        groups.lazy
            .map { $0.countAllAnswered() }
            .reduce(0, +)

    }
}
