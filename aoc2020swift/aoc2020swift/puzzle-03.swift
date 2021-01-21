//
//  puzzle-03.swift
//  aoc2020swift
//
//  Created by Matt Burke on 1/21/21.
//

import Foundation

enum GridSpace {
    case empty
    case tree

    static func parse(_ c: Character) -> GridSpace? {
        if c == "." { return GridSpace.empty }
        else if c == "#" { return GridSpace.tree }
        else { return nil }
    }
}


struct Grid {
    let definition: [[GridSpace]]
    let height: Int
    let width: Int

    func get(x: Int, y: Int) -> GridSpace {
        definition[y][x % width]
    }

    static func parse<T: StringProtocol>(_ input: [T]) -> Grid {
        let height = input.count
        let width = input[0].count

        var definition: [[GridSpace]] = []
        definition.reserveCapacity(height)

        for row in input {
            var outputRow: [GridSpace] = []
            outputRow.reserveCapacity(width)

            for col in row {
                let parsed = GridSpace.parse(col)!;
                outputRow.append(parsed)
            }

            definition.append(outputRow)
        }

        return Grid(definition: definition, height: height, width: width);
    }

    func walk(dx: Int, dy: Int) -> AnyIterator<(x: Int, y: Int, space: GridSpace)> {

        var x = 0;
        var y = 0;

        return AnyIterator<(x: Int, y: Int, space: GridSpace)> {
            if y >= height {
                return nil;
            }

            let result = (x, y, get(x: x, y: y))
            x += dx
            y += dy
            return result
        }
    }
}

struct Puzzle03 {
    static func run() {
        let input = Utils.readLines("puzzle-03")
        let grid = Grid.parse(input!)

        let treeCount = grid.walk(dx: 3, dy: 1).filter { $0.space == .tree }.count
        print("You encounter \(treeCount) trees running over 3 and down 1")
    }
}

