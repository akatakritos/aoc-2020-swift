//
//  Puzzle06Tests.swift
//  aoctests
//
//  Created by Matt Burke on 1/24/21.
//

import XCTest

class Puzzle06Tests: XCTestCase {

    func testSample() {
        let group1 = CustomsGroup.parse("abc")
        XCTAssertEqual(group1.countUniqueAnswers(), 3)
        XCTAssertEqual(group1.countWho(answered: "a"), 1)
    }

    func testSample2() {
        let group = CustomsGroup.parse("""
                ab
                ac
                """)

        XCTAssertEqual(group.countUniqueAnswers(), 3)
        XCTAssertEqual(group.countWho(answered: "a"), 2)
        XCTAssertEqual(group.countWho(answered: "b"), 1)
    }

    func testWholeSampleBatch() {
        let input = """
        abc

        a
        b
        c

        ab
        ac

        a
        a
        a
        a

        b
        """

        let batch = GroupList.parse(input)

        XCTAssertEqual(batch.sumCountUniqueAnswers(), 11)
    }

    func testPart1() {
        let input = Utils.readSample(inputName: "puzzle-06")!
        let batch = GroupList.parse(input)

        XCTAssertEqual(batch.sumCountUniqueAnswers(), 6587)
    }

    func testPart2() {
        let input = Utils.readSample(inputName: "puzzle-06")!
        let batch = GroupList.parse(input)

        XCTAssertEqual(batch.sumCountAllAnswered(), 3235)
    }

}
