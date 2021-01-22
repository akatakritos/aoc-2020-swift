//
//  Puzzle04Tests.swift
//  aoctests
//
//  Created by Matt Burke on 1/22/21.
//

import XCTest
@testable import aoc2020swift

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

        let validCount = batch.filter { $0.valid }.count
        XCTAssertEqual(validCount, 2)

        XCTAssertTrue(batch[0].valid)
        XCTAssertFalse(batch[1].valid)
        XCTAssertTrue(batch[2].valid)
        XCTAssertFalse(batch[3].valid)

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

        print(batch.count)

        let validCount = batch.filter { $0.valid }.count

        XCTAssertEqual(validCount, 245)
    }


}
