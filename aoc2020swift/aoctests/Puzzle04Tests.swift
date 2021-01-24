//
//  Puzzle04Tests.swift
//  aoctests
//
//  Created by Matt Burke on 1/22/21.
//

import XCTest

class Puzzle04Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPassportParse() {
        let input = """
        ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
        byr:1937 iyr:2017 cid:147 hgt:183cm
        """

        print(input)

        let passport = Passport.parse(input)
        XCTAssertNotNil(passport)
        XCTAssertNotNil(passport?.birthYear)

    }

    func testCountValidInBatch() {
        let input = """
        ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
        byr:1937 iyr:2017 cid:147 hgt:183cm

        iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
        hcl:#cfa07d byr:1929

        hcl:#ae17e1 iyr:2013
        eyr:2024
        ecl:brn pid:760753108 byr:1931
        hgt:179cm

        hcl:#cfa07d eyr:2025 pid:166559648
        iyr:2011 ecl:brn hgt:59in
        """

        let batch = PassportBatch.parse(input)
        XCTAssertEqual(batch.count, 4)

        let validCount = batch.filter { $0.complete }.count
        XCTAssertEqual(validCount, 2)

        XCTAssertTrue(batch[0].complete)
        XCTAssertFalse(batch[1].complete)
        XCTAssertTrue(batch[2].complete)
        XCTAssertFalse(batch[3].complete)

    }

    func testParseUnitlessHeight() {
        let input = """
        hcl:#733820 hgt:175 eyr:2028 iyr:2011
        pid:87786389
        ecl:hzl byr:1980
        """

        let passport = Passport.parse(input)
        XCTAssertNotNil(passport!.height)
        XCTAssertEqual(passport!.height!.height, 175)
        XCTAssertEqual(passport!.height!.unit, .none)
    }

    func testPart1() {
        let input = Utils.readSample(inputName: "puzzle-04")!
        let batch = PassportBatch.parse(input)


        let validCount = batch.filter { $0.complete }.count
        XCTAssertEqual(validCount, 245)
    }

    func testCasesPart2() {
        let input = """
        eyr:1972 cid:100
        hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

        iyr:2019
        hcl:#602927 eyr:1967 hgt:170cm
        ecl:grn pid:012533040 byr:1946

        hcl:dab227 iyr:2012
        ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

        hgt:59cm ecl:zzz
        eyr:2038 hcl:74454a iyr:2023
        pid:3556412378 byr:2007
        """
        let batch = PassportBatch.parse(input)
        let allInvalid = batch.allSatisfy { !$0.valid }
        XCTAssertTrue(allInvalid, "All items should be invalid but were not")

        let validInput = """
        pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
        hcl:#623a2f

        eyr:2029 ecl:blu cid:129 byr:1989
        iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

        hcl:#888785
        hgt:164cm byr:2001 iyr:2015 cid:88
        pid:545766238 ecl:hzl
        eyr:2022

        iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
        """
        let validBatch = PassportBatch.parse(validInput)
        let allValid = validBatch.allSatisfy { $0.valid }
        XCTAssertTrue(allValid, "All items should be valid but were not")
    }

    func testPart2() {
        let input = Utils.readSample(inputName: "puzzle-04")!
        let batch = PassportBatch.parse(input)

        let validCount = batch.filter { $0.valid }.count
        XCTAssertEqual(validCount, 133)

    }


}
