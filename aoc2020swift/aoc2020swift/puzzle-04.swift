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
    case none

    static func parse<T: StringProtocol>(_ s: T) -> HeightUnit {
        switch s {
        case "cm": return .centimeters
        case "in": return .inches
        default: return .none
        }
    }
}

private func parseHeight<T: StringProtocol>(_ s: T) -> (height: Int, unit: HeightUnit)? {
    guard let match = SimpleRegex.match(pattern: "^(\\d+)(in|cm)?$", target: s) else {
        print("Failed to parse [\(s)] as a height")
        return nil
    }
    let height = match.groups[1]
    let measure = match.groups[2]

    let measurement = HeightUnit.parse(measure)

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
            case "byr": birthYear = Int(fieldValue)!
            case "iyr": issueYear = Int(fieldValue)!
            case "eyr": expirationYear = Int(fieldValue)!
            case "hgt": height = parseHeight(fieldValue)!
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

    var complete: Bool {
        birthYear != nil
        && issueYear != nil
        && expirationYear != nil
        && height != nil
        && hairColor != nil
        && eyeColor != nil
        && passportId != nil
        // countryId not required
    }

    private func validHeight() -> Bool {
        switch height {
        case let (height: cms, unit: .centimeters)?: return cms >= 150 && cms <= 193
        case let (height: inches, unit: .inches)?: return inches >= 59 && inches <= 76
        default: return false
        }
    }

    private func validHairColor() -> Bool {
        guard let color = hairColor else { return false }
        return SimpleRegex.isMatch(pattern: "^#[0-9a-f]{6}$", target: color)
    }

    private func validEyeColor() -> Bool {
        switch eyeColor {
        case "amb", "blu", "brn", "gry", "grn", "hzl", "oth": return true
        default: return false
        }
    }

    private func validPassport() -> Bool {
        guard let id = passportId else { return false }
        return SimpleRegex.isMatch(pattern: "^[0-9]{9}$", target: id)
    }

    var valid: Bool {

        birthYear != nil && birthYear! >= 1920 && birthYear! <= 2002
        && issueYear != nil && issueYear! >= 2010 && issueYear! <= 2020
        && expirationYear != nil && expirationYear! >= 2020 && expirationYear! <= 2030
        && validHeight()
        && validHairColor()
        && validEyeColor()
        && validPassport()
    }
}

struct PassportBatch {
    static func parse<T: StringProtocol>(_ s: T) -> [Passport] {
        let passports = s.components(separatedBy: "\n\n")
        return passports.map { Passport.parse($0)! }
    }
}
