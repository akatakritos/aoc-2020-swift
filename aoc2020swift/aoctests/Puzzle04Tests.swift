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


}
