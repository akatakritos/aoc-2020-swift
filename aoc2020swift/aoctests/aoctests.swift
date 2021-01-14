//
//  aoctests.swift
//  aoctests
//
//  Created by Matt Burke on 1/14/21.
//

import XCTest

class aoctests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let expenses = [
            1721,
            979,
            366,
            299,
            675,
            1456
        ]

        let (a, b) = Puzzle01.findEntries(expenses, summingTo: 2020)!
        XCTAssertEqual(a, 1721)
        XCTAssertEqual(b, 299)
    }
}
