import XCTest

class Puzzle02Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPasswordParsing() throws {
        let test = PasswordTest.parse("1-3 a: abcde")
        let expected = PasswordTest(policy: PasswordPolicy(letter: "a", min: 1, max: 3), password: "abcde")
        XCTAssertEqual(expected, test);
    }
}
