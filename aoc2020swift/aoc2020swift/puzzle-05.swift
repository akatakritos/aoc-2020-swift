//
//  puzzle-05.swift
//  aoc2020swift
//
//  Created by Matt Burke on 1/23/21.
//

import Foundation

enum RowInstruction {
    case front
    case back

    static func parse(_ c: Character) -> RowInstruction? {
        switch c {
        case "F": return .front
        case "B": return .back
        default: return nil
        }
    }
}

enum SeatInstruction {
    case left
    case right

    static func parse(_ c: Character) -> SeatInstruction? {
        switch c {
        case "R": return .right
        case "L": return .left
        default: return  nil
        }
    }
}

struct SeatId<T: StringProtocol> {
    let id: T
    private let seatInstructions: [SeatInstruction]
    private let rowInstructions: [RowInstruction]

    init (id: T) {
        assert(id.count == 10)

        self.id = id

        let switchPoint = id.index(id.startIndex, offsetBy: 7)
        self.rowInstructions = id[..<switchPoint].map { RowInstruction.parse($0)! }
        self.seatInstructions = id[switchPoint...].map { SeatInstruction.parse($0)! }

        assert(rowInstructions.count == 7)
        assert(seatInstructions.count == 3)
    }

    func seatNumber() -> Int {
        let row = evaluateRow(min: 0, max: 127, at: 0)
        let seat = evaluateSeat(min: 0, max: 7, at: 0)
        return row * 8 + seat
    }

    private func evaluateSeat(min: Int, max: Int, at index: Int) -> Int {
        if min == max { return min }

        let midpoint = Int(floor(Float(min + max) / 2.0))
        let instruction = seatInstructions[index]
        switch instruction {
        case .left: return evaluateSeat(min: min, max: midpoint, at: index + 1)
        case .right: return evaluateSeat(min: midpoint + 1, max: max, at: index + 1)
        }

    }


    private func evaluateRow(min: Int, max: Int, at index: Int) -> Int {

        if min == max { return min }

        let midpoint = Int(floor(Float(min + max) / 2.0))
        let instruction = rowInstructions[index]
        switch instruction {
        case .front: return evaluateRow(min: min, max: midpoint, at: index + 1)
        case .back: return evaluateRow(min: midpoint + 1, max: max, at: index + 1)
        }
    }
}
