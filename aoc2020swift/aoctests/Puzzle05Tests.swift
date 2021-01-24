//
//  Puzzle05Tests.swift
//  aoctests
//
//  Created by Matt Burke on 1/23/21.
//

import XCTest

class Puzzle05Tests: XCTestCase {


    func testSeatId() {
        let seat = SeatId(id: "FBFBBFFRLR")

        XCTAssertEqual(seat.seatNumber(), 357)
    }

    func testPart1() {
        let max = Utils.readLines("puzzle-05")!
            .lazy
            .map { SeatId(id: $0) }
            .map { $0.seatNumber() }
            .max()

        XCTAssertEqual(max, 938)

    }

}
