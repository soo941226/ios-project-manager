//
//  View.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/01.
//

import SwiftUI

extension View {
    func onSwipeToDelete(deleteAction: @escaping () -> Void) -> some View {
        self.modifier(DeleteSwiper(delete: deleteAction))
    }
}
