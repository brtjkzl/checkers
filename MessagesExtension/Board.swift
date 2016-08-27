//
//  Board.swift
//  Checkers
//
//  Created by bkzl on 26/08/16.
//  Copyright © 2016 bkzl. All rights reserved.
//

import Messages

class Board {
    private var pieces = Array2D<Piece>(columns: Settings.boardSize, rows: Settings.boardSize)
    private let newGameSetupKey = "w00,w20,w40,w60,w11,w31,w51,w71,w02,w22,w42,w62,r15,r35,r55,r75,r06,r26,r46,r66,r17,r37,r57,r77"

    var setupKey: String {
        var setup: [String] = []
        for row in 0..<Settings.boardSize {
            for column in 0..<Settings.boardSize {
                if let piece = pieces[column, row] {
                    setup.append("\(piece.pieceType.symbol)\(piece.column)\(piece.row)")
                }
            }
        }
        return setup.joined(separator: ",")
    }

    func pieceAt(column: Int, row: Int) -> Piece? {
        guard column >= 0 && column < Settings.boardSize else { return nil }
        guard row >= 0 && row < Settings.boardSize else { return nil }

        return pieces[column, row]
    }

    func isPieceAt(column: Int, row: Int) -> Bool {
        return pieceAt(column: column, row: row) != nil
    }

    func move(piece: Piece, to: (column: Int, row: Int)) {
        pieces[piece.column, piece.row] = nil
        piece.column = to.column
        piece.row = to.row
        pieces[to.column, to.row] = piece
    }

    init(message: MSMessage?) {
        if let message = message {
            // TODO
        } else {
            setUpBoard(with: newGameSetupKey)
        }

    }

    private func setUpBoard(with setup: String) {
        for piece in setup.components(separatedBy: ",") {
            let setup = Array(piece.characters)
            let pieceType = PieceType.bySymbol(String(setup[0]))!
            let column = Int(String(setup[1]))!
            let row = Int(String(setup[2]))!

            pieces[column, row] = Piece(column: column, row: row, pieceType: pieceType)
        }
    }
}
