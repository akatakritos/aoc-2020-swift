//
//  puzzle-03-tests.swift
//  aoctests
//
//  Created by Matt Burke on 1/21/21.
//

import XCTest

class Puzzle03Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGridParsing() {
        let input = """
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        """

        let lines = Utils.splitLines(input)
        let grid = Grid.parse(lines)

        XCTAssertEqual(grid.width, 11)
        XCTAssertEqual(grid.height, 11)
        XCTAssertEqual(grid.get(x: 0, y: 0), .empty)
        XCTAssertEqual(grid.get(x: 0, y: 0), .empty)
        XCTAssertEqual(grid.get(x: 10, y: 10), .tree)
    }

    func testCanRepeatHorizontally() {
        let input = """
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        """

        let lines = Utils.splitLines(input)
        let grid = Grid.parse(lines)

        XCTAssertEqual(grid.get(x: 13, y: 5), .tree)
    }

    func testWalk() {
        let input = """
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        """

        let lines = Utils.splitLines(input)
        let grid = Grid.parse(lines)

        let trees = grid.walk(dx: 3, dy: 1).filter { $0.space == .tree }

        XCTAssertEqual(trees.count, 7)
    }

    func testPartA() {
        let input = Utils.readLines("puzzle-03")
        let grid = Grid.parse(input!)

        let treeCount = grid.walk(dx: 3, dy: 1).filter { $0.space == .tree }.count
        XCTAssertEqual(280, treeCount)
    }

    func testPartB() {
        let input = Utils.readLines("puzzle-03")
        let grid = Grid.parse(input!)
        let slopes = [
            (dx: 1, dy: 1),
            (dx: 3, dy: 1),
            (dx: 5, dy: 1),
            (dx: 7, dy: 1),
            (dx: 1, dy: 2),
        ]

        func countTrees(slope: (dx: Int, dy: Int)) -> Int {
            grid.walk(dx: slope.dx, dy: slope.dy).filter { $0.space == .tree }.count
        }

        let result = slopes
            .map(countTrees)
            .reduce(1) { (product, element) in product * element }

        XCTAssertEqual(4355551200, result)
    }
}
