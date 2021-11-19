//
//  Memo.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

struct Memo: Hashable, Equatable {
    let id: UUID
    var title: String
    var body: String
    var date: Date
    var state: State

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
    }
    
    var isEmpty: Bool {
        return title.isEmpty && body.isEmpty
    }
    
    mutating func update(with memo: Memo) {
        self.title = memo.title
        self.body = memo.body
        self.date = memo.date
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    enum State: Int, CaseIterable, CustomStringConvertible {
        case todo = 0
        case doing = 1
        case done = 2

        var description: String {
            switch self {
            case .todo:
                return "TODO"
            case .doing:
                return "DOING"
            case .done:
                return "DONE"
            }
        }
    }
}
