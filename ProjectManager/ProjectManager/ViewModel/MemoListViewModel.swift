//
//  MemoViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

final class MemoListViewModel: ObservableObject {
    @Published private var currentState: ActionState = .read
    private(set) var memoList: [Memo.State: [Memo]] = [:]

    init() {
        Memo.State.allCases.forEach { state in
            memoList[state] = []
        }
    }

    enum ActionState {
        case read
        case create
        case update(Memo)
        case delete
    }
}

// MARK: - Update Interface
extension MemoListViewModel: MemoContentChangable {
    var memoToEdit: Memo? {
        guard case .update(let memo) = currentState else {
            return nil
        }

        return memo
    }

    func edit(_ memo: Memo) {
        if case .create = currentState {
            insert(memo)
        } else if case .update(let updatingMemo) = currentState {
            update(from: updatingMemo, to: memo)
        } else {
            print("there is nothing to do")
        }
    }
}

// MARK: - Create, Read, Delete Interface
extension MemoListViewModel {
    func list(about state: Memo.State) -> [Memo] {
        return memoList[state] ?? []
    }

    func joinToCreateMemo() {
        currentState = .create
    }

    func joinToUpdate(_ memo: Memo) {
        currentState = .update(memo)
    }

    func afterEdit() {
        currentState = .read
    }

    func delete(_ memo: Memo, from state: Memo.State) {
        guard let index = memoList[state]?.firstIndex(of: memo) else {
            return
        }

        currentState = .delete
        memoList[state]?.remove(at: index)
        currentState = .read
    }
}

// MARK: - CRUD Logic
extension MemoListViewModel {
    private func insert(_ memo: Memo) {
        if memo.isEmpty {
            return
        }

        memoList[.todo]?.insert(memo, at: .zero)
    }

    private func update(from old: Memo, to new: Memo) {
        let state = old.state

        if let target = memoList[state]?.firstIndex(of: old) {
            memoList[state]?[target].update(with: new)
        }
    }
}

// MARK: Adopting delegation
extension MemoListViewModel: MemoRowViewModelDelegate {
    func updateMemo(with memo: Memo) {
        currentState = .update(memo)

        DispatchQueue.global().async {
            let statesToFind = Memo.State.allCases.filter { $0 != memo.state }

            statesToFind.forEach { [weak self] state in
                let memoPreviousIndex = self?.memoList[state]?.firstIndex(
                    where: { target in target.id == memo.id })
                if let index = memoPreviousIndex {
                    self?.memoList[state]?.remove(at: index)
                    self?.memoList[memo.state]?.insert(memo, at: .zero)
                }
            }

            DispatchQueue.main.async { [weak self] in
                self?.currentState = .read
            }
        }
    }
}
