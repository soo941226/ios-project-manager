//
//  ViewModelDelegates.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/20.
//

import Foundation

protocol MemoRowViewModelDelegate: AnyObject {
    func updateMemo(with memo: Memo)
}
