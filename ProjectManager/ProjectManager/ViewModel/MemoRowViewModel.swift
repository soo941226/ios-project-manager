//
//  MemoRowViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/07.
//

import SwiftUI

final class MemoRowViewModel: ObservableObject {
    @Published private(set) var memo: Memo
    @Published private(set) var isPopover = false
    weak var delegate: MemoRowViewModelDelegate?

    lazy private(set) var isLongPressed = Binding<Bool> {
        self.isPopover
    } set: { bool in
        self.isPopover = bool
    }

    private let dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.locale = Locale.current
        result.dateStyle = .medium
        result.timeStyle = .none
        return result
    }()

    init(memo: Memo, delegate: MemoRowViewModelDelegate) {
        self.memo = memo
        self.delegate = delegate
    }

    func showPopover() {
        isPopover = true
    }

    func hidePopover() {
        isPopover = false
    }
}

// MARK: - Expression Style
extension MemoRowViewModel: MemoExpressionable {
    func yyyyMMdd(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func color(about memo: Memo) -> Color {
        guard memo.state != .done else {
            return .black
        }

        let currentDate = yyyyMMdd(from: Date())
        let describedDate = yyyyMMdd(from: memo.date)

        if let currentTime = dateFormatter.date(from: currentDate),
           let describedTime = dateFormatter.date(from: describedDate),
           describedTime < currentTime {
            return .red
        } else {
            return .black
        }
    }
}

// MARK: - State editor
extension MemoRowViewModel: MemoStateChangable {
    var changableState: [Memo.State] {
        return Memo.State.allCases.filter { state in state != memo.state }
    }

    func updateState(with state: Memo.State) {
        memo.state = state
        delegate?.updateMemo(with: memo)
    }
}
