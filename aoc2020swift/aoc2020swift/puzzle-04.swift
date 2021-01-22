//
//  puzzle-04.swift
//  aoc2020swift
//
//  Created by Matt Burke on 1/22/21.
//

import Foundation

enum HeightUnit {
    case centimeters
    case inches

    static func parse<T: StringProtocol>(_ s: T) -> HeightUnit? {
        switch s {
        case "cm": return .centimeters
        case "in": return .inches
        default: return nil
        }
    }
}

private func parseHeight<T: StringProtocol>(_ s: T) -> (height: Int, unit: HeightUnit)? {
    guard let match = SimpleRegex.match(pattern: "^(\\d+)(in|cm)$", target: s) else { return nil }
    let height = match.groups[1]
    guard let measurement = HeightUnit.parse(match.groups[2]) else { return nil }

    return (height: Int(height)!, unit: measurement)
}

struct Passport {
    let birthYear: Int?
    let issueYear: Int?
    let expirationYear: Int?
    let height: (height: Int, unit: HeightUnit)?
    let hairColor: String?
    let eyeColor: String?
    let passportId: String?
    let countryId: String?

    static func parse<T: StringProtocol>(_ s: T) -> Passport? {
        let fields = Utils.splitLines(String(s)).flatMap { line in line.split(separator: " ") }

        var birthYear: Int? = nil
        var issueYear: Int? = nil
        var expirationYear: Int? = nil
        var height: (height: Int, unit: HeightUnit)? = nil
        var hairColor: String? = nil
        var eyeColor: String? = nil
        var passportId: String? = nil
        var countryId: String? = nil


        for field in fields {
            let parts = field.split(separator: ":")
            let fieldName = String(parts[0])
            let fieldValue = String(parts[1])
            switch fieldName {
            case "byr": birthYear = Int(fieldValue)
            case "iyr": issueYear = Int(fieldValue)
            case "eyr": expirationYear = Int(fieldValue)
            case "hgt": height = parseHeight(fieldValue)
            case "hcl": hairColor = fieldValue
            case "ecl": eyeColor = fieldValue
            case "pid": passportId = fieldValue
            case "cid": countryId = fieldValue
            default:
                return nil;
            }
        }

        return Passport(birthYear: birthYear,
                        issueYear: issueYear,
                        expirationYear: expirationYear,
                        height: height,
                        hairColor: hairColor,
                        eyeColor: eyeColor,
                        passportId: passportId,
                        countryId: countryId
        )

    }
}
