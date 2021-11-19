//
//  MemoRelatives.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/20.
//

import SwiftUI

protocol MemoExpressionable {
    var memo: Memo { get }
    var isLongPressed: Binding<Bool> { get }
    func yyyyMMdd(from date: Date) -> String
    func color(about memo: Memo) -> Color
}

protocol MemoStateChangable {
    var changableState: [Memo.State] { get }
    func updateState(with state: Memo.State)
    func hidePopover()
}

protocol MemoContentChangable {
    var memoToEdit: Memo? { get }
    func edit(_ memo: Memo)
}
